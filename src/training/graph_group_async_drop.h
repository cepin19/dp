#pragma once

#include "training/graph_group_async.h"

#include "training/gradient_dropping/dropper.h"
#include "training/gradient_dropping/sparse_tensor.h"

namespace marian {

class AsyncGraphGroupDrop : public AsyncGraphGroup {
  std::vector<int> fetchStep_;
  std::vector<int> pushStep_;
  std::vector<bool> fetch_ready;

  bool drop_first = 1;

  size_t dropping_warmup;
  float droping_rate;
  float dropping_momentum;

  std::vector<std::vector<GradientDrop>> droppers_;

  std::vector<std::vector<SparseTensor>> sparseGrads_, sparseShards_;

protected:
  void init(Ptr<data::Batch> batch) override;
  void pushGradients(Tensor newGrads, int device_id) override;
  void fetchParams(Tensor oldParams,
                   const std::vector<Tensor>& params,
                   int device_id) override;

public:
  AsyncGraphGroupDrop(Ptr<Options> options, Ptr<IMPIWrapper> mpi)
      : AsyncGraphGroup(options, mpi),
        dropping_warmup{options->get<size_t>("grad-dropping-warmup")},
        droping_rate{options->get<float>("grad-dropping-rate")},
        dropping_momentum{options->get<float>("grad-dropping-momentum")} {}
};
}  // namespace marian
