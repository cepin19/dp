#include <random>

#include "data/corpus.h"

namespace marian {
namespace data {

typedef std::vector<size_t> WordBatch;
typedef std::vector<float> MaskBatch;
typedef std::pair<WordBatch, MaskBatch> WordMask;
typedef std::vector<WordMask> SentBatch;

CorpusIterator::CorpusIterator() : pos_(-1), tup_(0) {}

CorpusIterator::CorpusIterator(CorpusBase* corpus)
    : corpus_(corpus), pos_(0), tup_(corpus_->next()) {}

void CorpusIterator::increment() {
  tup_ = corpus_->next();
  pos_++;
}

bool CorpusIterator::equal(CorpusIterator const& other) const {
  return this->pos_ == other.pos_ || (this->tup_.empty() && other.tup_.empty());
}

const SentenceTuple& CorpusIterator::dereference() const {
  return tup_;
}

CorpusBase::CorpusBase(const std::vector<std::string>& paths,
                       const std::vector<Ptr<Vocab>>& vocabs,
                       Ptr<Options> options)
    : DatasetBase(paths, options),
      vocabs_(vocabs),
      maxLength_(options_->get<size_t>("max-length")),
      maxLengthCrop_(options_->get<bool>("max-length-crop")),
      rightLeft_(options_->get<bool>("right-left")) {
  ABORT_IF(paths_.size() != vocabs_.size(),
           "Number of corpus files and vocab files does not agree");

  for(auto path : paths_) {
    files_.emplace_back(new io::InputFileStream(path));
    ABORT_IF(files_.back()->empty(), "File '{}' is empty", path);
  }

  initEOS(/*training=*/true);
}

CorpusBase::CorpusBase(Ptr<Options> options, bool translate)
    : DatasetBase(options),
      maxLength_(options_->get<size_t>("max-length")),
      maxLengthCrop_(options_->get<bool>("max-length-crop")),
      rightLeft_(options_->get<bool>("right-left")) {
  bool training = !translate;

  if(training)
    paths_ = options_->get<std::vector<std::string>>("train-sets");
  else
    paths_ = options_->get<std::vector<std::string>>("input");

  initEOS(training);

  std::vector<std::string> vocabPaths;
  if(!options_->get<std::vector<std::string>>("vocabs").empty())
    vocabPaths = options_->get<std::vector<std::string>>("vocabs");

  if(training) {
    ABORT_IF(!vocabPaths.empty() && paths_.size() != vocabPaths.size(),
             "Number of corpus files and vocab files does not agree");
  }

  // @TODO: check if size_t can be used instead of int
  std::vector<int> maxVocabs = options_->get<std::vector<int>>("dim-vocabs");

  // training or scoring
  if(training) {
    if(vocabPaths.empty()) {
      if(maxVocabs.size() < paths_.size())
        maxVocabs.resize(paths_.size(), 0);

      LOG(info, "No vocabulary files given, trying to find or build based on training data. "
                "Vocabularies will be built separately for each file.");

      // Create vocabs if not provided
      for(size_t i = 0; i < paths_.size(); ++i) {
        Ptr<Vocab> vocab = New<Vocab>(options_, i);
        std::vector<std::string> trainPaths = { paths_[i] };
        size_t vocSize = vocab->loadOrCreate("", trainPaths, maxVocabs[i]);
        // TODO: this is not nice as it modifies the option object and needs to expose the changes
        // outside the corpus as models need to know about the vocabulary size; extract the vocab
        // creation functionality from the class.
        options_->getYaml()["dim-vocabs"][i] = vocSize;

        options_->getYaml()["vocabs"].push_back(paths_[i] + ".yml");
        vocabs_.emplace_back(vocab);
      }
    } else {
      // Load all vocabs
      if(maxVocabs.size() < vocabPaths.size())
        maxVocabs.resize(paths_.size(), 0);

      // Helper object to for grouping training data based on vocabulary file name
      struct PathsAndSize {
        std::set<std::string> paths; // contains all paths that are used for training the vocabulary
        size_t size;                 // contains the maximum vocabulary size
      };

      // Group training files based on vocabulary path. If the same
      // vocab path corresponds to different training files, this means
      // that a single vocab should combine tokens from all files.
      std::map<std::string, PathsAndSize> groupVocab;
      for(size_t i = 0; i < vocabPaths.size(); ++i) {
        groupVocab[vocabPaths[i]].paths.insert(paths_[i]);
        if(groupVocab[vocabPaths[i]].size < maxVocabs[i])
          groupVocab[vocabPaths[i]].size = maxVocabs[i];
      }

      for(size_t i = 0; i < vocabPaths.size(); ++i) {
        Ptr<Vocab> vocab = New<Vocab>(options_, i);

        // Get the set of files that corresponds to the vocab. If the next file is the same vocab,
        // it wild not be created again, but just correctly loaded.
        auto pathsAndSize = groupVocab[vocabPaths[i]];
        std::vector<std::string> groupedPaths(pathsAndSize.paths.begin(), pathsAndSize.paths.end());
        size_t vocSize = vocab->loadOrCreate(vocabPaths[i], groupedPaths, pathsAndSize.size);

        // TODO: this is not nice as it modifies the option object and needs to expose the changes
        // outside the corpus, because models need to know about the vocabulary size; extract the
        // vocab creation functionality from the class.
        options_->getYaml()["dim-vocabs"][i] = vocSize;

        vocabs_.emplace_back(vocab);
      }
    }
  }

  if(translate) {
    ABORT_IF(vocabPaths.empty(),
             "Translating, but vocabularies are not given!");

    if(maxVocabs.size() < vocabPaths.size())
      maxVocabs.resize(paths_.size(), 0);

    for(size_t i = 0; i + 1 < vocabPaths.size(); ++i) {
      Ptr<Vocab> vocab = New<Vocab>(options_, i);
      size_t vocSize = vocab->load(vocabPaths[i], maxVocabs[i]);
      options_->getYaml()["dim-vocabs"][i] = vocSize;

      vocabs_.emplace_back(vocab);
    }
  }

  for(auto path : paths_) {
    if(path == "stdin")
      files_.emplace_back(new io::InputFileStream(std::cin));
    else {
      files_.emplace_back(new io::InputFileStream(path));
      ABORT_IF(files_.back()->empty(), "File '{}' is empty", path);
    }
  }

  ABORT_IF(vocabs_.size() != files_.size(),
           "Number of {} files ({}) and vocab files ({}) does not agree",
           training ? "corpus" : "input",
           files_.size(),
           vocabs_.size());

  if(training && options_->get("guided-alignment", std::string("none")) != "none") {
    auto path = options_->get<std::string>("guided-alignment");

    ABORT_IF(!filesystem::exists(path), "Alignment file does not exist");
    LOG(info, "[data] Using word alignments from file {}", path);

    alignFileIdx_ = paths_.size();
    paths_.emplace_back(path);
    files_.emplace_back(new io::InputFileStream(path));
    ABORT_IF(files_.back()->empty(), "File with alignments '{}' is empty", path);
  }

  if(training && options_->hasAndNotEmpty("data-weighting")) {
    auto path = options_->get<std::string>("data-weighting");

    ABORT_IF(!filesystem::exists(path), "Weight file does not exist");
    LOG(info, "[data] Using weights from file {}", path);

    weightFileIdx_ = paths_.size();
    paths_.emplace_back(path);
    files_.emplace_back(new io::InputFileStream(path));
    ABORT_IF(files_.back()->empty(), "File with weights '{}' is empty", path);
  }
}

void CorpusBase::addWordsToSentenceTuple(const std::string& line,
                                         size_t batchIndex,
                                         SentenceTuple& tup) const {

  // This turns a string in to a sequence of numerical word ids. Depending
  // on the vocabulary type, this can be non-trivial, e.g. when SentencePiece
  // is used.
  Words words = vocabs_[batchIndex]->encode(line, /*addEOS =*/ addEOS_[batchIndex], inference_);

  if(words.empty())
    words.push_back(0);

  if(maxLengthCrop_ && words.size() > maxLength_) {
    words.resize(maxLength_);
    words.back() = 0;
  }

  if(rightLeft_)
    std::reverse(words.begin(), words.end() - 1);

  tup.push_back(words);
}

void CorpusBase::addAlignmentToSentenceTuple(const std::string& line,
                                             SentenceTuple& tup) const {
  ABORT_IF(rightLeft_,
           "Guided alignment and right-left model cannot be used "
           "together at the moment");

  auto align = WordAlignment(line);
  tup.setAlignment(align);
}

void CorpusBase::addWeightsToSentenceTuple(const std::string& line, SentenceTuple& tup) const {
  auto elements = utils::split(line, " ");

  if(!elements.empty()) {
    std::vector<float> weights;
    for(auto& e : elements) {
      if(maxLengthCrop_ && weights.size() > maxLength_)
        break;
      weights.emplace_back(std::stof(e));
    }

    if(rightLeft_)
      std::reverse(weights.begin(), weights.end());

    tup.setWeights(weights);
  }
}

void CorpusBase::addAlignmentsToBatch(Ptr<CorpusBatch> batch,
                                      const std::vector<Sample>& batchVector) {
  int srcWords = (int)batch->front()->batchWidth();
  int trgWords = (int)batch->back()->batchWidth();
  int dimBatch = (int)batch->getSentenceIds().size();

  std::vector<float> aligns(srcWords * dimBatch * trgWords, 0.f);

  for(int b = 0; b < dimBatch; ++b) {
    for(auto p : batchVector[b].getAlignment()) {
      size_t idx = p.srcPos * dimBatch * trgWords + b * trgWords + p.tgtPos;
      aligns[idx] = 1.f;
    }
  }
  batch->setGuidedAlignment(std::move(aligns));
}

void CorpusBase::addWeightsToBatch(Ptr<CorpusBatch> batch,
                                   const std::vector<Sample>& batchVector) {
  int dimBatch = (int)batch->size();
  int trgWords = (int)batch->back()->batchWidth();

  auto sentenceLevel
      = options_->get<std::string>("data-weighting-type") == "sentence";
  size_t size = sentenceLevel ? dimBatch : dimBatch * trgWords;
  std::vector<float> weights(size, 1.f);

  for(int b = 0; b < dimBatch; ++b) {
    if(sentenceLevel) {
      weights[b] = batchVector[b].getWeights().front();
    } else {
      size_t i = 0;
      for(auto& w : batchVector[b].getWeights()) {
        weights[b + i * dimBatch] = w;
        ++i;
      }
    }
  }

  batch->setDataWeights(weights);
}

void CorpusBase::initEOS(bool training = true) {
  // Labels fed into sub-batches that are just class-labels, not sequence labels do not require to
  // add a EOS symbol. Hence decision to add EOS is now based on input stream positions and correspoding
  // input type.

  addEOS_.resize(paths_.size(), true);
  // @TODO: think if this should be checked and processed here or in a validation step in config?
  auto inputTypes = options_->get<std::vector<std::string>>("input-types", {}); // empty list by default

  // make sure there is an input type for each path
  ABORT_IF(inputTypes.size() > 0 && inputTypes.size() < paths_.size(),
           "Input types have been specified ({}), you need to specify one per input ({})",
           inputTypes.size(),
           paths_.size());

  // make sure there is an equal number of input types and paths when training
  ABORT_IF(training && inputTypes.size() > 0 && inputTypes.size() != paths_.size(),
           "Input types have been specified ({}), you need to specify one per input ({})",
           inputTypes.size(),
           paths_.size());

  for(int i = 0; i < paths_.size(); ++i)
    if(inputTypes.size() > i) {
      if(inputTypes[i] == "class")
        addEOS_[i] = false;
      else if(inputTypes[i] == "sequence")
        addEOS_[i] = true;
      else
        ABORT("Unknown input type {}: {}", i, inputTypes[i]);
    } else {
      // No input type specified, assuming "sequence"
      addEOS_[i] = true;
    }
}

}  // namespace data
}  // namespace marian
