#include "layers/loss.h"

namespace marian {

// @TODO, simplify this. Currently here for back-compat
Ptr<LabelwiseLoss> newLoss(Ptr<Options> options, bool inference) {
  float smoothing = inference ? 0.f : options->get<float>("label-smoothing");
  std::string costType = options->get<std::string>("cost-type", "ce-mean");
  
  if(costType == "ce-rescore") {
    return New<RescorerLoss>();
  } else if(costType == "ce-rescore-mean") {
    ABORT("Check me");
    return New<RescorerLoss>();
  } else {  // same as ce-mean
    return New<CrossEntropyLoss>(smoothing);
  }
}

// see loss.h for detailed explanations of each class
Ptr<MultiRationalLoss> newMultiLoss(Ptr<Options> options) {
    std::string multiLossType = options->get<std::string>("multi-loss-type", "sum");
    if(multiLossType == "sum")         // sum of sums
      return New<SumMultiRationalLoss>();
    else if(multiLossType == "scaled") // sum of scaled sums, first element is reference scale
      return New<ScaledMultiRationalLoss>();
    else if(multiLossType == "mean")   // sum of means
      return New<MeanMultiRationalLoss>();
    else
      ABORT("Unknown multi-loss-type {}", multiLossType);

    return nullptr;
}

}  // namespace marian
