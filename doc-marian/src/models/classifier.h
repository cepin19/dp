#pragma once

#include "marian.h"
#include "models/states.h"
#include "layers/constructors.h"
#include "layers/factory.h"

namespace marian {

/**
 * Simple base class for Classifiers to be used in EncoderClassifier framework
 * Currently only implementations are in bert.h
 */
class ClassifierBase {
protected:
  Ptr<Options> options_;
  std::string prefix_{"classifier"};
  bool inference_{false};
  size_t batchIndex_{0};

public:
  ClassifierBase(Ptr<Options> options)
      : options_(options),
        prefix_(options->get<std::string>("prefix", "classifier")),
        inference_(options->get<bool>("inference", false)),
        batchIndex_(options->get<size_t>("index", 1)) {} // assume that training input has batch index 0 and labels has 1

  virtual ~ClassifierBase() {}

  virtual Ptr<ClassifierState> apply(Ptr<ExpressionGraph>, Ptr<data::CorpusBatch>, const std::vector<Ptr<EncoderState>>&) = 0;

  template <typename T>
  T opt(const std::string& key) const {
    return options_->get<T>(key);
  }

  // Should be used to clear any batch-wise temporary objects if present
  virtual void clear() = 0;
};

}