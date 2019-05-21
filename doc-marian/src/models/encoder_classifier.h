#pragma once

#include "marian.h"

#include "models/encoder.h"
#include "models/classifier.h"
#include "models/model_base.h"
#include "models/states.h"

namespace marian {

/**
 * Combines sequence encoders with generic classifiers
 * Can be used to train sequence classifiers like language detection, BERT-next-sentence-prediction etc.
 * Already has support for multi-objective training.
 *
 * @TODO: this should probably be unified somehow with EncoderDecoder which could allow for deocder/classifier
 * multi-objective training.
 */
class EncoderClassifierBase : public models::ModelBase {
public:
  virtual ~EncoderClassifierBase() {}

  virtual void load(Ptr<ExpressionGraph> graph,
                    const std::string& name,
                    bool markedReloaded = true) override
      = 0;

  virtual void mmap(Ptr<ExpressionGraph> graph,
                    const void* ptr,
                    bool markedReloaded = true)
      = 0;

  virtual void save(Ptr<ExpressionGraph> graph,
                    const std::string& name,
                    bool saveTranslatorConfig = false) override
      = 0;

  virtual void clear(Ptr<ExpressionGraph> graph) override = 0;

  virtual std::vector<Ptr<ClassifierState>> apply(Ptr<ExpressionGraph>, Ptr<data::CorpusBatch>, bool) = 0;


  virtual Ptr<RationalLoss> build(Ptr<ExpressionGraph> graph,
                                  Ptr<data::Batch> batch,
                                  bool clearGraph = true) override = 0;

  virtual Ptr<RationalLoss> build(Ptr<ExpressionGraph> graph,
                                  Ptr<data::CorpusBatch> batch,
                                  bool clearGraph = true) = 0;

  virtual Ptr<Options> getOptions() = 0;
};

class EncoderClassifier : public EncoderClassifierBase {
protected:
  Ptr<Options> options_;

  std::string prefix_;

  std::vector<Ptr<EncoderBase>> encoders_;
  std::vector<Ptr<ClassifierBase>> classifiers_;

  bool inference_{false};

  std::set<std::string> modelFeatures_;

  Config::YamlNode getModelParameters() {
    Config::YamlNode modelParams;
    for(auto& key : modelFeatures_)
        modelParams[key] = options_->getYaml()[key];

    if(options_->has("original-type"))
        modelParams["type"] = options_->getYaml()["original-type"];

    modelParams["version"] = buildVersion();
    return modelParams;
  }

  std::string getModelParametersAsString() {
    auto yaml = getModelParameters();
    YAML::Emitter out;
    cli::OutputYaml(yaml, out);
    return std::string(out.c_str());
  }

public:
  typedef data::Corpus dataset_type;

  // @TODO: lots of code-duplication with EncoderDecoder
  EncoderClassifier(Ptr<Options> options)
    : options_(options),
      prefix_(options->get<std::string>("prefix", "")),
      inference_(options->get<bool>("inference", false)) {
  modelFeatures_ = {"type",
                    "dim-vocabs",
                    "dim-emb",
                    "dim-rnn",
                    "enc-cell",
                    "enc-type",
                    "enc-cell-depth",
                    "enc-depth",
                    "dec-depth",
                    "dec-cell",
                    "dec-cell-base-depth",
                    "dec-cell-high-depth",
                    "skip",
                    "layer-normalization",
                    "right-left",
                    "input-types",
                    "special-vocab",
                    "tied-embeddings",
                    "tied-embeddings-src",
                    "tied-embeddings-all"};

    modelFeatures_.insert("transformer-heads");
    modelFeatures_.insert("transformer-no-projection");
    modelFeatures_.insert("transformer-dim-ffn");
    modelFeatures_.insert("transformer-ffn-depth");
    modelFeatures_.insert("transformer-ffn-activation");
    modelFeatures_.insert("transformer-dim-aan");
    modelFeatures_.insert("transformer-aan-depth");
    modelFeatures_.insert("transformer-aan-activation");
    modelFeatures_.insert("transformer-aan-nogate");
    modelFeatures_.insert("transformer-preprocess");
    modelFeatures_.insert("transformer-postprocess");
    modelFeatures_.insert("transformer-postprocess-emb");
    modelFeatures_.insert("transformer-decoder-autoreg");
    modelFeatures_.insert("transformer-tied-layers");
    modelFeatures_.insert("transformer-guided-alignment-layer");
    modelFeatures_.insert("transformer-train-position-embeddings");

    modelFeatures_.insert("bert-train-type-embeddings");
    modelFeatures_.insert("bert-type-vocab-size");

    modelFeatures_.insert("ulr");
    modelFeatures_.insert("ulr-trainable-transformation");
    modelFeatures_.insert("ulr-dim-emb");
  }

  virtual Ptr<Options> getOptions() override { return options_; }

  std::vector<Ptr<EncoderBase>>& getEncoders() { return encoders_; }
  std::vector<Ptr<ClassifierBase>>& getClassifiers() { return classifiers_; }

  void push_back(Ptr<EncoderBase> encoder) { encoders_.push_back(encoder); }
  void push_back(Ptr<ClassifierBase> classifier) { classifiers_.push_back(classifier); }

  void load(Ptr<ExpressionGraph> graph,
            const std::string& name,
            bool markedReloaded) override {
    graph->load(name, markedReloaded && !opt<bool>("ignore-model-config", false));
  }

  void mmap(Ptr<ExpressionGraph> graph,
            const void* ptr,
            bool markedReloaded) override {
    graph->mmap(ptr, markedReloaded && !opt<bool>("ignore-model-config", false));
  }

  void save(Ptr<ExpressionGraph> graph,
            const std::string& name,
            bool /*saveModelConfig*/) override {
    LOG(info, "Saving model weights and runtime parameters to {}", name);
    graph->save(name , getModelParametersAsString());
  }

  void clear(Ptr<ExpressionGraph> graph) override {
    graph->clear();

    for(auto& enc : encoders_)
      enc->clear();
    for(auto& cls : classifiers_)
      cls->clear();
  }

  template <typename T>
  T opt(const std::string& key) {
    return options_->get<T>(key);
  }

  template <typename T>
  T opt(const std::string& key, const T& def) {
    return options_->get<T>(key, def);
  }

  template <typename T>
  void set(std::string key, T value) {
    options_->set(key, value);
  }

  /*********************************************************************/

  virtual std::vector<Ptr<ClassifierState>> apply(Ptr<ExpressionGraph> graph, Ptr<data::CorpusBatch> batch, bool clearGraph) override {
    if(clearGraph)
      clear(graph);

    std::vector<Ptr<EncoderState>> encoderStates;
    for(auto& encoder : encoders_)
        encoderStates.push_back(encoder->build(graph, batch));

    std::vector<Ptr<ClassifierState>> classifierStates;
    for(auto& classifier : classifiers_)
      classifierStates.push_back(classifier->apply(graph, batch, encoderStates));

    return classifierStates;
  }

  virtual Ptr<RationalLoss> build(Ptr<ExpressionGraph> graph,
                                  Ptr<data::CorpusBatch> batch,
                                  bool clearGraph = true) override {
    auto states = apply(graph, batch, clearGraph);
    // returns raw logits
    return New<RationalLoss>(states[0]->getLogProbs(), nullptr); // @TODO: Check if this is actually used
  }

  virtual Ptr<RationalLoss> build(Ptr<ExpressionGraph> graph,
                                  Ptr<data::Batch> batch,
                                  bool clearGraph = true) override {
    auto corpusBatch = std::static_pointer_cast<data::CorpusBatch>(batch);
    return build(graph, corpusBatch, clearGraph);
  }
};

}  // namespace marian
