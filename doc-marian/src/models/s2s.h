#pragma once

#include "marian.h"

#include "layers/constructors.h"
#include "rnn/attention_constructors.h"
#include "rnn/constructors.h"

namespace marian {

class EncoderS2S : public EncoderBase {
public:
  Expr applyEncoderRNN(Ptr<ExpressionGraph> graph,
                       Expr embeddings,
                       Expr mask,
                       std::string type) {
    int first, second;
    if(type == "bidirectional" || type == "alternating") {
      // build two separate stacks, concatenate top output
      first = opt<int>("enc-depth");
      second = 0;
    } else {
      // build 1-layer bidirectional stack, concatenate,
      // build n-1 layer unidirectional stack
      first = 1;
      second = opt<int>("enc-depth") - first;
    }

    auto forward = type == "alternating" ? rnn::dir::alternating_forward
                                         : rnn::dir::forward;

    auto backward = type == "alternating" ? rnn::dir::alternating_backward
                                          : rnn::dir::backward;

    float dropoutRnn = inference_ ? 0 : opt<float>("dropout-rnn");

    auto rnnFw = rnn::rnn()                                        //
        ("type", opt<std::string>("enc-cell"))                     //
        ("direction", (int)forward)                                //
        ("dimInput", embeddings->shape()[-1])                      //
        ("dimState", opt<int>("dim-rnn"))                          //
        ("dropout", dropoutRnn)                                    //
        ("layer-normalization", opt<bool>("layer-normalization"))  //
        ("skip", opt<bool>("skip"));

    for(int i = 1; i <= first; ++i) {
      auto stacked = rnn::stacked_cell();
      for(int j = 1; j <= opt<int>("enc-cell-depth"); ++j) {
        std::string paramPrefix = prefix_ + "_bi";
        if(i > 1)
          paramPrefix += "_l" + std::to_string(i);
        if(i > 1 || j > 1)
          paramPrefix += "_cell" + std::to_string(j);
        bool transition = (j > 1);

        stacked.push_back(rnn::cell()              //
                          ("prefix", paramPrefix)  //
                          ("transition", transition));
      }
      rnnFw.push_back(stacked);
    }

    auto rnnBw = rnn::rnn()                                        //
        ("type", opt<std::string>("enc-cell"))                     //
        ("direction", (int)backward)                               //
        ("dimInput", embeddings->shape()[-1])                      //
        ("dimState", opt<int>("dim-rnn"))                          //
        ("dropout", dropoutRnn)                                    //
        ("layer-normalization", opt<bool>("layer-normalization"))  //
        ("skip", opt<bool>("skip"));

    for(int i = 1; i <= first; ++i) {
      auto stacked = rnn::stacked_cell();
      for(int j = 1; j <= opt<int>("enc-cell-depth"); ++j) {
        std::string paramPrefix = prefix_ + "_bi_r";
        if(i > 1)
          paramPrefix += "_l" + std::to_string(i);
        if(i > 1 || j > 1)
          paramPrefix += "_cell" + std::to_string(j);
        bool transition = (j > 1);

        stacked.push_back(rnn::cell()              //
                          ("prefix", paramPrefix)  //
                          ("transition", transition));
      }
      rnnBw.push_back(stacked);
    }

    auto context = concatenate({rnnFw.construct(graph)->transduce(embeddings, mask),
                                rnnBw.construct(graph)->transduce(embeddings, mask)},
                               /*axis =*/ -1);

    if(second > 0) {
      // add more layers (unidirectional) by transducing the output of the
      // previous bidirectional RNN through multiple layers

      // construct RNN first
      auto rnnUni = rnn::rnn()                                       //
          ("type", opt<std::string>("enc-cell"))                     //
          ("dimInput", 2 * opt<int>("dim-rnn"))                      //
          ("dimState", opt<int>("dim-rnn"))                          //
          ("dropout", dropoutRnn)                                    //
          ("layer-normalization", opt<bool>("layer-normalization"))  //
          ("skip", opt<bool>("skip"));

      for(int i = first + 1; i <= second + first; ++i) {
        auto stacked = rnn::stacked_cell();
        for(int j = 1; j <= opt<int>("enc-cell-depth"); ++j) {
          std::string paramPrefix = prefix_ + "_l" + std::to_string(i) + "_cell"
                                    + std::to_string(j);
          stacked.push_back(rnn::cell()("prefix", paramPrefix));
        }
        rnnUni.push_back(stacked);
      }

      // transduce context to new context
      context = rnnUni.construct(graph)->transduce(context);
    }
    return context;
  }

  Ptr<IEmbeddingLayer> createSourceEmbedding(Ptr<ExpressionGraph> graph) {
    // create source embeddings
    int dimVoc = opt<std::vector<int>>("dim-vocabs")[batchIndex_];
    int dimEmb = opt<int>("dim-emb");

    auto embFactory = embedding()  //
        ("dimVocab", dimVoc)       //
        ("dimEmb", dimEmb);

    if(opt<bool>("tied-embeddings-src") || opt<bool>("tied-embeddings-all"))
      embFactory("prefix", "Wemb");
    else
      embFactory("prefix", prefix_ + "_Wemb");

    if(options_->has("embedding-fix-src"))
      embFactory("fixed", opt<bool>("embedding-fix-src"));

    if(options_->hasAndNotEmpty("embedding-vectors")) {
      auto embFiles = opt<std::vector<std::string>>("embedding-vectors");
      embFactory                              //
          ("embFile", embFiles[batchIndex_])  //
          ("normalization", opt<bool>("embedding-normalization"));
    }

    return embFactory.construct(graph);
  }

  EncoderS2S(Ptr<Options> options) : EncoderBase(options) {}

  virtual Ptr<EncoderState> build(Ptr<ExpressionGraph> graph,
                                  Ptr<data::CorpusBatch> batch) override {
    auto embedding = createSourceEmbedding(graph);

    // select embeddings that occur in the batch
    Expr batchEmbeddings, batchMask; std::tie
    (batchEmbeddings, batchMask) = embedding->apply((*batch)[batchIndex_]);

    // apply dropout over source words
    float dropProb = inference_ ? 0 : opt<float>("dropout-src");
    if(dropProb) {
      int srcWords = batchEmbeddings->shape()[-3];
      batchEmbeddings = dropout(batchEmbeddings, dropProb, {srcWords, 1, 1});
    }

    Expr context = applyEncoderRNN(
        graph, batchEmbeddings, batchMask, opt<std::string>("enc-type"));

    return New<EncoderState>(context, batchMask, batch);
  }

  void clear() override {}
};

class DecoderS2S : public DecoderBase {
private:
  Ptr<rnn::RNN> rnn_;
  Ptr<mlp::MLP> output_;

  Ptr<rnn::RNN> constructDecoderRNN(Ptr<ExpressionGraph> graph,
                                    Ptr<DecoderState> state) {
    float dropoutRnn = inference_ ? 0 : opt<float>("dropout-rnn");
    auto rnn = rnn::rnn()                                          //
        ("type", opt<std::string>("dec-cell"))                     //
        ("dimInput", opt<int>("dim-emb"))                          //
        ("dimState", opt<int>("dim-rnn"))                          //
        ("dropout", dropoutRnn)                                    //
        ("layer-normalization", opt<bool>("layer-normalization"))  //
        ("nematus-normalization",
         options_->has("original-type")
             && opt<std::string>("original-type") == "nematus")  //
        ("skip", opt<bool>("skip"));

    size_t decoderLayers = opt<size_t>("dec-depth");
    size_t decoderBaseDepth = opt<size_t>("dec-cell-base-depth");
    size_t decoderHighDepth = opt<size_t>("dec-cell-high-depth");

    // setting up conditional (transitional) cell
    auto baseCell = rnn::stacked_cell();
    for(size_t i = 1; i <= decoderBaseDepth; ++i) {
      bool transition = (i > 2);
      auto paramPrefix = prefix_ + "_cell" + std::to_string(i);
      baseCell.push_back(rnn::cell()              //
                         ("prefix", paramPrefix)  //
                         ("final", i > 1)         //
                         ("transition", transition));
      if(i == 1) {
        for(size_t k = 0; k < state->getEncoderStates().size(); ++k) {
          auto attPrefix = prefix_;
          if(state->getEncoderStates().size() > 1)
            attPrefix += "_att" + std::to_string(k + 1);

          auto encState = state->getEncoderStates()[k];

          baseCell.push_back(rnn::attention()("prefix", attPrefix).set_state(encState));
        }
      }
    }
    // Add cell to RNN (first layer)
    rnn.push_back(baseCell);

    // Add more cells to RNN (stacked RNN)
    for(size_t i = 2; i <= decoderLayers; ++i) {
      // deep transition
      auto highCell = rnn::stacked_cell();

      for(size_t j = 1; j <= decoderHighDepth; j++) {
        auto paramPrefix
            = prefix_ + "_l" + std::to_string(i) + "_cell" + std::to_string(j);
        highCell.push_back(rnn::cell()("prefix", paramPrefix));
      }

      // Add cell to RNN (more layers)
      rnn.push_back(highCell);
    }

    return rnn.construct(graph);
  }

public:
  DecoderS2S(Ptr<Options> options) : DecoderBase(options) {}

  virtual Ptr<DecoderState> startState(
      Ptr<ExpressionGraph> graph,
      Ptr<data::CorpusBatch> batch,
      std::vector<Ptr<EncoderState>>& encStates) override {

    std::vector<Expr> meanContexts;
    for(auto& encState : encStates) {
      // average the source context weighted by the batch mask
      // this will remove padded zeros from the average
      meanContexts.push_back(weighted_average(
          encState->getContext(), encState->getMask(), /*axis =*/ -3));
    }

    Expr start;
    if(!meanContexts.empty()) {
      // apply single layer network to mean to map into decoder space
      auto mlp = mlp::mlp().push_back(
          mlp::dense()                                               //
          ("prefix", prefix_ + "_ff_state")                          //
          ("dim", opt<int>("dim-rnn"))                               //
          ("activation", (int)mlp::act::tanh)                        //
          ("layer-normalization", opt<bool>("layer-normalization"))  //
          ("nematus-normalization",
          options_->has("original-type")
               && opt<std::string>("original-type") == "nematus")  //
      )
      .construct(graph);

      start = mlp->apply(meanContexts);
    } else {
      int dimBatch = (int)batch->size();
      int dimRnn = opt<int>("dim-rnn");

      start = graph->constant({dimBatch, dimRnn}, inits::zeros);
    }

    rnn::States startStates(opt<size_t>("dec-depth"), {start, start});
    return New<DecoderState>(startStates, nullptr, encStates, batch);
  }

  virtual Ptr<DecoderState> step(Ptr<ExpressionGraph> graph,
                                 Ptr<DecoderState> state) override {

    auto embeddings = state->getTargetEmbeddings();

    // dropout target words
    float dropoutTrg = inference_ ? 0 : opt<float>("dropout-trg");
    if(dropoutTrg) {
      int trgWords = embeddings->shape()[-3];
      embeddings = dropout(embeddings, dropoutTrg, {trgWords, 1, 1});
    }

    if(!rnn_)
      rnn_ = constructDecoderRNN(graph, state);

    // apply RNN to embeddings, initialized with encoder context mapped into
    // decoder space
    auto decoderContext = rnn_->transduce(embeddings, state->getStates());

    // retrieve the last state per layer. They are required during translation
    // in order to continue decoding for the next word
    rnn::States decoderStates = rnn_->lastCellStates();

    std::vector<Expr> alignedContexts;
    for(int k = 0; k < state->getEncoderStates().size(); ++k) {
      // retrieve all the aligned contexts computed by the attention mechanism
      auto att = rnn_->at(0)
                     ->as<rnn::StackedCell>()
                     ->at(k + 1)
                     ->as<rnn::Attention>();
      alignedContexts.push_back(att->getContext());
    }

    Expr alignedContext;
    if(alignedContexts.size() > 1)
      alignedContext = concatenate(alignedContexts, /*axis =*/ -1);
    else if(alignedContexts.size() == 1)
      alignedContext = alignedContexts[0];

    if(!output_) {
      // construct deep output multi-layer network layer-wise
      auto hidden = mlp::dense()                                     //
          ("prefix", prefix_ + "_ff_logit_l1")                       //
          ("dim", opt<int>("dim-emb"))                               //
          ("activation", mlp::act::tanh)                             //
          ("layer-normalization", opt<bool>("layer-normalization"))  //
          ("nematus-normalization",
           options_->has("original-type")
               && opt<std::string>("original-type") == "nematus");

      int dimTrgVoc = opt<std::vector<int>>("dim-vocabs")[batchIndex_];

      auto last = mlp::output()                 //
          ("prefix", prefix_ + "_ff_logit_l2")  //
          ("dim", dimTrgVoc);

      if(opt<bool>("tied-embeddings") || opt<bool>("tied-embeddings-all")) {
        std::string tiedPrefix = prefix_ + "_Wemb";
        if(opt<bool>("tied-embeddings-all") || opt<bool>("tied-embeddings-src"))
          tiedPrefix = "Wemb";
        last.tieTransposed(tiedPrefix);
      }

      if(shortlist_)
        last.setShortlist(shortlist_);

      // assemble layers into MLP and apply to embeddings, decoder context and
      // aligned source context
      output_ = mlp::mlp()              //
                    .push_back(hidden)  //
                    .push_back(last)
                    .construct(graph);
    }

    Expr logits;
    if(alignedContext)
      logits = output_->apply(embeddings, decoderContext, alignedContext);
    else
      logits = output_->apply(embeddings, decoderContext);

    // return unormalized(!) probabilities
    auto nextState = New<DecoderState>(
        decoderStates, logits, state->getEncoderStates(), state->getBatch());

    // Advance current target token position by one
    nextState->setPosition(state->getPosition() + 1);
    return nextState;
  }

  // helper function for guided alignment
  virtual const std::vector<Expr> getAlignments(int i = 0) override {
    auto att
        = rnn_->at(0)->as<rnn::StackedCell>()->at(i + 1)->as<rnn::Attention>();
    return att->getAlignments();
  }

  void clear() override {
    rnn_ = nullptr;
    output_ = nullptr;
  }
};
}  // namespace marian
