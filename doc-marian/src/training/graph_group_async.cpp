#include "training/graph_group_async.h"
#include "data/corpus_base.h"
#include "functional/functional.h"
#include "tensors/tensor_operators.h"

namespace marian {

AsyncGraphGroup::AsyncGraphGroup(Ptr<Options> config, Ptr<IMPIWrapper> mpi)
    : GraphGroup(config),
      ExponentialSmoothing(options_),
      devices_{Config::getDevices(options_)},
      shardSync_(devices_.size()),
      optimizerDelay_((size_t)options_->get<double>("optimizer-delay")) {
  ABORT_IF(mpi->numMPIProcesses() != 1, "AsyncGraphGroup presently does not support multiple MPI processes");
  ABORT_IF((double)optimizerDelay_ != options_->get<double>("optimizer-delay"), "AsyncGraphGroup presently does not implement fractional values for --optimizer-delay");
  pool_.reset(new ThreadPool(devices_.size(), devices_.size()));

  for(auto device : devices_) {
    auto graph = New<ExpressionGraph>();
    graph->setDevice(device);
    graph->getBackend()->setClip(options_->get<float>("clip-gemm"));
    graph->reserveWorkspaceMB(options_->get<size_t>("workspace"));
    graphs_.push_back(graph);
    shardOpt_.push_back(Optimizer(options_));

    builders_.push_back(models::from_options(options_, models::usage::training));
  }
}

void AsyncGraphGroup::setScheduler(Ptr<Scheduler> scheduler) {
  scheduler_ = scheduler;
  // optimizer has to be registered last to see changes of learning rate
  scheduler_->registerTrainingObserver(scheduler_);

  for(auto opt : shardOpt_)
    scheduler_->registerTrainingObserver(opt);
}

void AsyncGraphGroup::fetchParams(Tensor oldParams,
                                  const std::vector<Tensor>& params,
                                  int /*device_id*/) {
  // @TODO read guard on parameters
  int pos = 0;

  std::vector<std::thread> threads;
  for(int idx = 0; idx < devices_.size(); idx++) {
    threads.emplace_back(std::thread(
        [&](int idx, int pos) {
          // individual mutex per-shard
          std::lock_guard<std::mutex> guard(shardSync_[idx]);
          oldParams->subtensor((int)pos, (int)params[idx]->size())->copyFrom(params[idx]);
        },
        idx,
        pos));

    pos += shardSize_;
  }
  for(auto&& t : threads) {
    t.join();
  }
}

void AsyncGraphGroup::pushGradients(Tensor newGrads,
                                    int /*device_id*/) {
  // add instead of copy?
  std::vector<std::thread> threads;
  int pos = 0;
  for(int idx = 0; idx < devices_.size(); idx++) {
    threads.emplace_back(std::thread(
        [&](int idx, int pos) {
          // individual mutex per-shard
          std::lock_guard<std::mutex> guard(shardSync_[idx]);
          grads_[idx]->copyFrom(newGrads->subtensor(pos, (int)grads_[idx]->size()));

          shardOpt_[idx]->update(params_[idx], grads_[idx]);

          if(mvAvg_)
            updateAvgParams(
                paramsAvg_[idx], params_[idx], scheduler_->numberOfBatches());
        },
        idx,
        pos));

    pos += shardSize_;
  }
  for(auto&& t : threads)
    t.join();
}

void AsyncGraphGroup::init(Ptr<data::Batch> batch) {
  // initialize the parameters
  {
    ThreadPool pool(graphs_.size(), graphs_.size());
    for(size_t i = 0; i < graphs_.size(); ++i) {
      auto init = [&](size_t i) {
        builders_[i]->build(graphs_[i], batch);
        graphs_[i]->forward();
      };
      pool.enqueue(init, i);
    }
  }

  if(params_.empty()) {
    int totalSize = (int)graphs_[0]->params()->vals()->size();
    shardSize_ = (int)ceil(totalSize / (float)devices_.size());

    int pos = 0;
    // parameter sharding
    for(auto graph : graphs_) {
      int __size__ = std::min(shardSize_, totalSize);
      totalSize -= __size__;

      Tensor param;
      Ptr<TensorAllocator> allocator
          = New<TensorAllocator>(graph->getBackend());
      allocator->reserveExact(__size__ * sizeof(float));
      allocator->allocate(param, {1, __size__});
      paramsAlloc_.push_back(allocator);

      param->copyFrom(graphs_[0]->params()->vals()->subtensor(pos, __size__));
      params_.push_back(param);

      pos += __size__;
    }
  }
  if(grads_.empty()) {
    int totalSize = (int)graphs_[0]->params()->vals()->size();

    for(auto graph : graphs_) {
      int __size__ = std::min(shardSize_, totalSize);
      totalSize -= __size__;
      Tensor grad;
      Ptr<TensorAllocator> allocator
          = New<TensorAllocator>(graph->getBackend());

      allocator->reserveExact(__size__ * sizeof(float));
      allocator->allocate(grad, {1, __size__});
      gradsAlloc_.push_back(allocator);
      grads_.push_back(grad);
    }
  }
  if(mvAvg_ && paramsAvg_.empty()) {
    Ptr<ExpressionGraph> graphAvg;
    std::string name = options_->get<std::string>("model");
    if(filesystem::exists(name + ".orig.npz")) {
      // Load the averaged parameters into a temporary graph
      graphAvg = New<ExpressionGraph>();
      graphAvg->setDevice({0, DeviceType::cpu});
      graphAvg->load(name, false);
      graphAvg->forward();
    }

    int totalSize = (int)graphs_[0]->params()->vals()->size();

    int i = 0;
    int pos = 0;
    for(auto graph : graphs_) {
      int __size__ = std::min(shardSize_, totalSize);
      totalSize -= __size__;
      Tensor paramAvg;
      Ptr<TensorAllocator> allocator
          = New<TensorAllocator>(graph->getBackend());

      allocator->reserveExact(__size__ * sizeof(float));
      allocator->allocate(paramAvg, {1, __size__});

      if(graphAvg)
        paramAvg->copyFrom(graphAvg->params()->vals()->subtensor(pos, __size__));
      else
        paramAvg->copyFrom(params_[i++]);

      paramsAllocAvg_.push_back(allocator);
      paramsAvg_.push_back(paramAvg);

      pos += __size__;
    }

    if(graphAvg)
      graphAvg.reset();
  }
}

void AsyncGraphGroup::execute(Ptr<data::Batch> batch) {
  if(first_) {
    init(batch);
    first_ = false;
  }

  auto task = [this](Ptr<data::Batch> batch) {
    static size_t i = 0;
    thread_local Ptr<ExpressionGraph> graph;
    thread_local Ptr<models::ModelBase> builder;
    thread_local size_t t = 0;
    thread_local size_t num_seen_words = 0;
    thread_local size_t num_seen_sentences = 0;
    thread_local int t_id = 0;
    thread_local StaticLoss loss;

    thread_local Tensor accGradients;
    thread_local Ptr<TensorAllocator> accAlloc;

    if(!graph) {
      std::lock_guard<std::mutex> lock(sync_);
      t_id = (int)i;
      graph = graphs_[i];
      builder = builders_[i++];
    }

    Ptr<RationalLoss> dynamicLoss = builder->build(graph, batch);

    if(t % optimizerDelay_ == 0) {
      fetchParams(graph->params()->vals(), params_, t_id);
    }

    graph->forward();
    loss += *dynamicLoss;
    graph->backward();

    Tensor gradients;
    if(optimizerDelay_ > 1) {
      if(t == 0) {
        accAlloc = New<TensorAllocator>(graph->getBackend());
        accAlloc->reserveExact(graph->params()->grads()->memory()->size());
        accAlloc->allocate(accGradients, graph->params()->grads()->shape());
        accGradients->set(0);
      }

      using namespace functional;
      Element(_1 += _2, accGradients, graph->params()->grads());
      gradients = accGradients;

      // Keep track of how many words we've calculated the error from
      num_seen_words += batch->words();
      num_seen_sentences += batch->size();
    } else {
      gradients = graph->params()->grads();
    }

    t++;

    if(t % optimizerDelay_ == 0) {
      pushGradients(gradients, t_id);
      // Reset the counter of seen target words after gradient update
      if(optimizerDelay_ > 1)
        gradients->set(0);
    }

    if(t % optimizerDelay_ == 0 && scheduler_) {
      std::unique_lock<std::mutex> lock(schedulerMutex_);

      // Wait until the thread that wants to do validation is finished.
      pool_->wait_for_one(lock);

      if(optimizerDelay_ > 1) {
        std::vector<size_t> fakeLength = {1, 1};
        std::vector<Ptr<Vocab>> vocabs;
        auto fb = data::CorpusBatch::fakeBatch(fakeLength, vocabs, num_seen_sentences, NULL);
        fb->front()->setWords(num_seen_words);

        scheduler_->update(loss, fb);

        num_seen_words = 0;
        num_seen_sentences = 0;
      } else {
        scheduler_->update(loss, batch);
      }

      loss.reset();

      if(scheduler_->saving() || scheduler_->validating()) {
        // Wait with validation or saving until all other threads are done with
        // update.
        // We want to reuse the graphs for validation, so they need to be in
        // a safe state.
        pool_->wait_for_others(lock);

        if(mvAvg_)
          for(auto g : graphs_)
            fetchParams(g->params()->vals(), paramsAvg_, t_id);

        if(scheduler_->validating())
          scheduler_->validate(graphs_);

        if(scheduler_->saving())
          this->save(graph);

        // Validation or saving is done, tell other threads to continue work.
        pool_->notify_others();
      }
    }
  };

  pool_->enqueue(task, batch);
}

void AsyncGraphGroup::load() {
  if(!options_->get<bool>("no-reload")) {
    std::string name = options_->get<std::string>("model");

    if(filesystem::exists(name)) {
      if(scheduler_)
        scheduler_->load(name);

      std::string nameGraph = name;
      if(mvAvg_ && filesystem::exists(name + ".orig.npz"))
        // Load the original parameters from model.npz.orig.npz
        nameGraph += ".orig.npz";

      size_t i = 0;
      for(auto graph : graphs_)
        builders_[i++]->load(graph, nameGraph);

      // @TODO: probably we want to have the list of DeviceIds as an attribute
      std::vector<Ptr<Backend>> backends;
      for(auto graph : graphs_)
        backends.push_back(graph->getBackend());
      shardOpt_[0]->load(name + ".optimizer.npz", shardOpt_, backends,
        /*scatterStateFn=*/[&](const std::vector<float>& data, const OptimizerBase::ScatterStateSetFunc& setFn) {
          size_t dataSize = data.size();
          size_t numLocalDevices = graphs_.size();
          size_t shardSize = (dataSize + numLocalDevices - 1) / numLocalDevices;// (size_t)(ceil(dataSize / (float)numLocalDevices));
          for (size_t i = 0; i < numLocalDevices; i++) {
            size_t begin = i * shardSize;
            size_t end = std::min(begin + shardSize, dataSize);
            setFn(i, data.begin() + begin, data.begin() + end);
          }
        });
    } else if(options_->hasAndNotEmpty("pretrained-model")) {
      std::string nameInit = options_->get<std::string>("pretrained-model");
      LOG(info,
          "Initialize model weights with the pre-trained model {}",
          nameInit);
      size_t i = 0;
      for(auto graph : graphs_)
        builders_[i++]->load(graph, nameInit, false);
    }
  }
}

void AsyncGraphGroup::save(bool final /* = false */) {
  if(final && scheduler_) {
    if(mvAvg_ && !paramsAvg_.empty()) {
      // Save original parameters to model.orig.npz
      std::string name = options_->get<std::string>("model");
      builders_[0]->save(graphs_[0], name + ".orig.npz");
      // Switch to averaged parameters
      for(auto g : graphs_)
        fetchParams(g->params()->vals(), paramsAvg_, 0 /* safe? */);
    }

    scheduler_->validate(graphs_, true);
  }

  save(graphs_[0], final);
}

void AsyncGraphGroup::save(Ptr<ExpressionGraph> graph, bool final /*=false*/) {
  size_t idx = 0;
  for(size_t i = 0; i < graphs_.size(); ++i) {
    if(graph == graphs_[i]) {
      idx = i;
      break;
    }
  }

  std::string name = options_->get<std::string>("model");

  if(options_->get<bool>("overwrite")) {
    builders_[idx]->save(graphs_[idx], name, true);
    if(scheduler_)
      scheduler_->save(name);
  } else {
    if(!final) {
      std::string numberOfBatches
          = scheduler_ ? std::to_string(scheduler_->numberOfBatches())
                       : "unknown";
      std::string nameOverwrite = name;
      nameOverwrite.replace(
          name.size() - 4, 4, ".iter" + numberOfBatches + ".npz");
      builders_[idx]->save(graphs_[idx], nameOverwrite);
    }

    builders_[idx]->save(graphs_[idx], name, true);
    if(scheduler_)
      scheduler_->save(name);
  }

  shardOpt_[idx]->save(name + ".optimizer.npz", shardOpt_,
    /*gatherStateFn=*/[&](const OptimizerBase::GatherStateGetFunc& getFn) {
      std::vector<float> data;
      for (size_t i = 0; i < graphs_.size(); i++) {
        auto tmp = getFn(i);
        data.insert(data.end(), tmp.begin(), tmp.end());
      }
      return data;
    });
}

void AsyncGraphGroup::finalize() {
  pool_->join_all();  // call before destructing thread pool
  pool_.reset(nullptr);
  finalized_ = true;
}

}  // namespace marian
