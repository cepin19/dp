#include "data/vocab.h"
#include "data/vocab_base.h"

namespace marian {

Ptr<VocabBase> createDefaultVocab();
Ptr<VocabBase> createClassVocab();
Ptr<VocabBase> createSentencePieceVocab(const std::string& /*vocabPath*/, Ptr<Options>, size_t /*batchIndex*/);

// @TODO: make each vocab peek on type
Ptr<VocabBase> createVocab(const std::string& vocabPath, Ptr<Options> options, size_t batchIndex) {
  auto vocab = createSentencePieceVocab(vocabPath, options, batchIndex);
  if(vocab) {
    return vocab; // this is defined which means that a sentencepiece vocabulary could be created, so return it
  } else {
    // check type of input, if not given, assume "sequence"
    auto inputTypes = options->get<std::vector<std::string>>("input-types", {});
    std::string inputType = inputTypes.size() > batchIndex ? inputTypes[batchIndex] : "sequence";
    return inputType == "class" ? createClassVocab() : createDefaultVocab();
  }
}

size_t Vocab::loadOrCreate(const std::string& vocabPath,
                           const std::vector<std::string>& trainPaths,
                           size_t maxSize) {
  size_t size = 0;
  if(vocabPath.empty()) {
    // No vocabulary path was given, attempt to first find a vocabulary
    // for trainPaths[0] + possible suffixes. If not found attempt to create
    // as trainPaths[0] + canonical suffix.
    // Only search based on first path, maybe disable this at all?

    LOG(info,
        "No vocabulary path given; "
        "trying to find default vocabulary based on data path {}",
        trainPaths[0]);

    vImpl_ = createDefaultVocab();
    size = vImpl_->findAndLoad(trainPaths[0], maxSize);

    if(size == 0) {
      auto newVocabPath = trainPaths[0] + vImpl_->canonicalExtension();
      LOG(info,
          "No vocabulary path given; "
          "trying to create vocabulary based on data paths {}",
          utils::join(trainPaths, ", "));
      create(newVocabPath, trainPaths, maxSize);
      size = load(newVocabPath, maxSize);
    }
  } else {
    if(!filesystem::exists(vocabPath)) {
      // Vocabulary path was given, but no vocabulary present,
      // attempt to create in specified location.
      create(vocabPath, trainPaths, maxSize);
    }
    // Vocabulary path exists, attempting to load
    size = load(vocabPath, maxSize);
  }
  LOG(info, "[data] Setting vocabulary size for input {} to {}", batchIndex_, size);
  return size;
}

size_t Vocab::load(const std::string& vocabPath, size_t maxSize) {
  if(!vImpl_)
    vImpl_ = createVocab(vocabPath, options_, batchIndex_);
  return vImpl_->load(vocabPath, (int)maxSize);
}

void Vocab::create(const std::string& vocabPath,
                   const std::vector<std::string>& trainPaths,
                   size_t maxSize) {
  if(!vImpl_)
    vImpl_ = createVocab(vocabPath, options_, batchIndex_);
  vImpl_->create(vocabPath, trainPaths, maxSize);
}

void Vocab::create(const std::string& vocabPath,
                   const std::string& trainPath,
                   size_t maxSize) {
  create(vocabPath, std::vector<std::string>({trainPath}), maxSize);
}

void Vocab::createFake() {
  if(!vImpl_)
    vImpl_ = createDefaultVocab(); // DefaultVocab is OK here
  vImpl_->createFake();
}

// string token to token id
Word Vocab::operator[](const std::string& word) const {
  return vImpl_->operator[](word);
}

// token id to string token
const std::string& Vocab::operator[](Word id) const {
  return vImpl_->operator[](id);
}

// line of text to list of token ids, can perform tokenization
Words Vocab::encode(const std::string& line,
              bool addEOS,
              bool inference) const {
  return vImpl_->encode(line, addEOS, inference);
}

// list of token ids to single line, can perform detokenization
std::string Vocab::decode(const Words& sentence,
                    bool ignoreEOS) const {
  return vImpl_->decode(sentence, ignoreEOS);
}

// number of vocabulary items
size_t Vocab::size() const { return vImpl_->size(); }

// number of vocabulary items
std::string Vocab::type() const { return vImpl_->type(); }

// return EOS symbol id
Word Vocab::getEosId() const { return vImpl_->getEosId(); }

// return UNK symbol id
Word Vocab::getUnkId() const { return vImpl_->getUnkId(); }

}  // namespace marian
