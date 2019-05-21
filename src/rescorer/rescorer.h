#pragma once

#include "marian.h"

#include "common/config.h"
#include "common/options.h"
#include "data/batch_generator.h"
#include "data/corpus.h"
#include "data/corpus_nbest.h"
#include "models/costs.h"
#include "models/model_task.h"
#include "rescorer/score_collector.h"
#include "training/scheduler.h"
#include "training/validator.h"

namespace marian {

using namespace data;

class Rescorer {
private:
  Ptr<models::ModelBase> builder_;

public:
  Rescorer(Ptr<Options> options)
      : builder_(models::from_options(options, models::usage::scoring)) {}

  void load(Ptr<ExpressionGraph> graph, const std::string& modelFile) {
    builder_->load(graph, modelFile);
  }

  Ptr<RationalLoss> build(Ptr<ExpressionGraph> graph, Ptr<data::CorpusBatch> batch) {
    return builder_->build(graph, batch);
  }

  data::SoftAlignment getAlignment() {
    auto model = std::static_pointer_cast<models::Scorer>(builder_)->getModel();
    return std::static_pointer_cast<EncoderDecoderBase>(model)->getAlignment();
  }
};

template <class Model>
class Rescore : public ModelTask {
private:
  Ptr<Options> options_;
  Ptr<CorpusBase> corpus_;
  std::vector<Ptr<ExpressionGraph>> graphs_;
  std::vector<Ptr<Model>> models_;

public:
  Rescore(Ptr<Options> options) : options_(options) {
    ABORT_IF(options_->hasAndNotEmpty("summary") && options_->hasAndNotEmpty("alignment"),
             "Alignments can not be produced with summarized score");

    ABORT_IF(options_->hasAndNotEmpty("summary") && options_->get<bool>("normalize"),
             "Normalization by length cannot be used with summary scores");

    options_->set("inference", true);
    // @TODO: make normalize here a float and pass into loss to compute the same way as in decoding
    options_->set("cost-type", options_->get<bool>("normalize") ? "ce-rescore-mean" : "ce-rescore");

    if(options_->get<bool>("n-best"))
      corpus_ = New<CorpusNBest>(options_);
    else
      corpus_ = New<Corpus>(options_);
    corpus_->prepare();

    auto devices = Config::getDevices(options_);

    for(auto device : devices) {
      auto graph = New<ExpressionGraph>(true, options_->get<bool>("optimize"));
      graph->setDevice(device);
      graph->reserveWorkspaceMB(options_->get<size_t>("workspace"));
      graphs_.push_back(graph);
    }

    auto modelFile = options_->get<std::string>("model");

    models_.resize(graphs_.size());
    ThreadPool pool(graphs_.size(), graphs_.size());
    for(size_t i = 0; i < graphs_.size(); ++i) {
      pool.enqueue(
          [=](size_t j) {
            models_[j] = New<Model>(options_);
            models_[j]->load(graphs_[j], modelFile);
          },
          i);
    }
  }

  void run() override {
    LOG(info, "Scoring");

    auto batchGenerator = New<BatchGenerator<CorpusBase>>(corpus_, options_);
    batchGenerator->prepare(false);

    Ptr<ScoreCollector> output = options_->get<bool>("n-best")
                                     ? std::static_pointer_cast<ScoreCollector>(
                                           New<ScoreCollectorNBest>(options_))
                                     : New<ScoreCollector>(options_);

    auto alignment = options_->get<std::string>("alignment", "");
    auto summary = options_->get<std::string>("summary", "");
    bool summarize = !summary.empty();
    bool normalize = options_->get<bool>("normalize");

    float sumLoss = 0;
    size_t sumWords = 0;
    size_t sumSamples = 0;
    size_t batchId = 0;

    std::mutex smutex;
    {
      ThreadPool pool(graphs_.size(), graphs_.size());

      for(auto batch : *batchGenerator) {
        auto task = [=, &sumLoss, &sumWords, &sumSamples, &smutex](size_t id) {
          thread_local Ptr<ExpressionGraph> graph;
          thread_local Ptr<Model> builder;

          if(!graph) {
            graph = graphs_[id % graphs_.size()];
            builder = models_[id % graphs_.size()];
          }

          // @TODO: normalize by length as in normalize
          // Once we have Frank's concept of ce-sum with sample size by words we will return a pair
          // here which will make it trivial to report all variants.
          auto dynamicLoss = builder->build(graph, batch);

          graph->forward();

          std::vector<float> scores;
          dynamicLoss->loss(scores);

          // soft alignments for each sentence in the batch
          std::vector<data::SoftAlignment> aligns(batch->size());
          if(!alignment.empty()) {
            getAlignmentsForBatch(builder->getAlignment(), batch, aligns);
          }

          std::unique_lock<std::mutex> lock(smutex);
          for(auto s : scores)
            sumLoss += s;
          sumWords += batch->back()->batchWords();
          sumSamples += batch->size();

          if(!summarize) {
            for(size_t i = 0; i < batch->size(); ++i) {
              output->Write((long)batch->getSentenceIds()[i],
                             -1.f * scores[i], // report logProb while score is CE, hence negate
                             aligns[i]);
            }
          }

          // progress heartbeat for MS-internal Philly compute cluster
          // otherwise this job may be killed prematurely if no log for 4 hrs
          if (getenv("PHILLY_JOB_ID")   // this environment variable exists when running on the cluster
              && id % 1000 == 0)  // hard beat once every 1000 batches
          {
            auto progress = id / 10000.f; //fake progress for now, becomes >100 after 1M batches
            fprintf(stdout, "PROGRESS: %.2f%%\n", progress);
            fflush(stdout);
          }
        };

        pool.enqueue(task, batchId++);
      }
    }

    if(normalize) {
      LOG(info, "Total normalized log probs {} : Total sentences {} : Total words {}", sumLoss, sumSamples, sumWords);
      LOG(warn, "Sum of normalized log probs is a sum of averages");
    } else {
      LOG(info, "Total log probs {} : Total sentences {} : Total words {}", sumLoss, sumSamples, sumWords);
    }

    if(summarize) { // @TODO: use one function from loss
      float cost = 0;
      if(summary == "perplexity")
        cost = std::exp(sumLoss / (float)sumWords);
      else if(summary == "ce-sum")
        cost = sumLoss;
      else if(summary == "ce-mean-words")
        cost = sumLoss / (float)sumWords;
      else
        cost = sumLoss / sumSamples;

      LOG(info, "Reporting {} summary", summary);
      std::cout << cost << std::endl;
    }
  }

private:
  void getAlignmentsForBatch(const data::SoftAlignment& rawAligns,
                             Ptr<data::CorpusBatch> batch,
                             std::vector<data::SoftAlignment>& aligns) {
    // Raw word alignments is a vector of N x L, where N is the number of
    // sentences in the batch and L is the length of the longest sentence in the
    // batch, and are organized as follows:
    //   [word1-batch1, word1-batch2, ..., word2-batch1, ... ]
    // The last alignments are always for EOS tokens.

    // for each sentence in the batch
    for(size_t b = 0; b < batch->size(); ++b) {
      // for each target index
      for(size_t t = 0; t < rawAligns.size(); ++t) {
        // skip the rest if masked
        size_t t_idx = b + (t * batch->size());
        if(batch->back()->mask()[t_idx] == 0)
          continue;

        aligns[b].push_back({});

        // for each source index
        for(size_t s = b; s < rawAligns[t].size(); s += batch->size()) {
          // skip the rest if masked
          size_t s_idx = s;
          if(batch->front()->mask()[s_idx] == 0)
            continue;

          aligns[b][t].emplace_back(rawAligns[t][s]);
        }
      }
    }
  }
};

}  // namespace marian
