#include "data/vocab_base.h"

#ifdef USE_SENTENCEPIECE
#include "sentencepiece/src/sentencepiece_processor.h"
#include "sentencepiece/src/sentencepiece_trainer.h"
#endif

#include "common/config.h"
#include "common/options.h"
#include "common/logging.h"
#include "common/filesystem.h"
#include "common/regex.h"

#include <sstream>
#include <random>

namespace marian {

#ifdef USE_SENTENCEPIECE

// Wrapper around https://github.com/google/sentencepiece
class SentencePieceVocab : public VocabBase {
private:
  // Actual SentencePiece processor object
  UPtr<sentencepiece::SentencePieceProcessor> spm_;

  // Sampling factor for subword regularization, disabled when 0
  float alpha_{0};

  // Allowed suffixes for SentencePiece model
  std::vector<std::string> suffixes_ = {".spm"};

  Ptr<Options> options_;
  size_t batchIndex_{0};

  std::mt19937 generator_;
  std::uniform_int_distribution<int> randInt_; // from 0 to INT_MAX

  // Sample from one file, based on first algorithm from:
  // https://en.wikipedia.org/wiki/Reservoir_sampling
  void reservoirSampling(std::vector<std::string>& sample, size_t& seenLines,
                        const std::string& trainPath, size_t maxLines, size_t maxBytes) {

    ABORT_IF(maxLines == 0, "Sample needs to be larger 0");

    std::unique_ptr<io::InputFileStream> trainStrm(
      trainPath == "stdin" ? new io::InputFileStream(std::cin)
                           : new io::InputFileStream(trainPath)
    );

    std::string line;
    while(getline(*trainStrm, line)) {
      if(line.size() > 0 && line.size() < maxBytes) {
        if(sample.size() < maxLines) {
          sample.push_back(line);
        }
        else {
          size_t i = randInt_(generator_) % (seenLines + 1);
          if(i < maxLines)
            sample[i] = line;
        }
        seenLines++;
      }
    }
  }

  // Iterate over all input files and collect a representative sample via reservoir sampling.
  // The sample will first grow to the desired size and next keep sampling with decreasing
  // probability in the hope to get a uniform sample from the union of all files.
  size_t reservoirSamplingAll(io::TemporaryFile& temp,
                             const std::vector<std::string>& trainPaths,
                             size_t maxLines, size_t maxBytes) {
    LOG(info, "[SentencePiece] Sampling at most {} lines from {}", maxLines, utils::join(trainPaths, ", "));

    std::vector<std::string> sample;
    size_t seenLines = 0;
    for(const auto& trainPath : trainPaths)
      reservoirSampling(sample, seenLines, trainPath, maxLines, maxBytes);
    std::shuffle(sample.begin(), sample.end(), generator_);

    io::OutputFileStream out(temp);
    for(const auto& line : sample)
        out << line << std::endl;

    LOG(info, "[SentencePiece] Selected {} lines", sample.size());
    return sample.size();
  }

  // Just concatenate all files to a temporary file so SentencePiece can consume it.
  size_t dumpAll(io::TemporaryFile& temp,
                 const std::vector<std::string>& trainPaths,
                 size_t maxBytes) {
    LOG(info, "[SentencePiece] Selecting all lines from {}", utils::join(trainPaths, ", "));

    size_t seenLines = 0;
    std::string line;
    io::OutputFileStream out(temp);
    for(const auto& trainPath : trainPaths) {
      io::InputFileStream in(trainPath);
      while(getline(in, line)) {
        if(line.size() > 0 && line.size() < maxBytes) {
          out << line << std::endl;
          seenLines++;
        }
      }
    }

    LOG(info, "[SentencePiece] Selected {} lines", seenLines);
    return seenLines;
  }

public:
  SentencePieceVocab(Ptr<Options> options, size_t batchIndex)
    : options_(options), batchIndex_(batchIndex), generator_((uint32_t)Config::seed) {

    if(options_->has("sentencepiece-alphas")) {
      auto alphas = options_->get<std::vector<float>>("sentencepiece-alphas");
      if(alphas.size() <= batchIndex)
        alpha_ = 0.f;
      else
        alpha_ = alphas[batchIndex_];

      if(alpha_ > 0)
        LOG(debug,
            "Setting SentencePiece vocabulary sampling factor to {} for input {}",
            alpha_,
            batchIndex_);
    }

  }

  virtual const std::string& canonicalExtension() const override { return suffixes_[0]; }
  virtual const std::vector<std::string>& suffixes() const override { return suffixes_; }

  virtual std::string suffix() { return suffixes_[0]; };

  virtual std::string type() const override { return "SentencePieceVocab"; }

  virtual Word getEosId() const override { return (Word)spm_->eos_id(); }
  virtual Word getUnkId() const override { return (Word)spm_->unk_id(); }

  void create(const std::string& vocabPath,
              const std::vector<std::string>& trainPaths,
              size_t maxSize) override {

    size_t defaultMaxSize = 32000;
    size_t maxLines = options_->get<size_t>("sentencepiece-max-lines");
    size_t maxBytes = 2048;

    LOG(info, "[SentencePiece] Training SentencePiece vocabulary {}", vocabPath);

    if(maxSize == 0) {
      LOG(info, "[SentencePiece] Vocabulary size is undefined (set with --dim-vocabs ...) - setting to {}", defaultMaxSize);
      maxSize = defaultMaxSize;
    }

    // Create temporary file to hold the sample for the SentencePiece trainer
    io::TemporaryFile temp(options_->get<std::string>("tempdir"), false);
    std::string tempFileName = temp.getFileName();
    LOG(info, "[SentencePiece] Creating temporary file {}", tempFileName);

    size_t seenLines = 0;
    if(maxLines == 0)
      seenLines = dumpAll(temp, trainPaths, maxBytes);
    else
      seenLines = reservoirSamplingAll(temp, trainPaths, maxLines, maxBytes);

    // Compose the SentencePiece training command from filenames and parameters0
    std::stringstream command;
    command
      << " --bos_id=-1 --eos_id=0 --unk_id=1" // these should not be changed as they match Marian defaults
      << " --input="               << tempFileName
      << " --model_prefix="        << vocabPath
      << " --vocab_size="          << maxSize
      << " --max_sentence_length=" << maxBytes
      << " --input_sentence_size=" << seenLines
      << " " << options_->get<std::string>("sentencepiece-options"); // these are SentencePiece command line options

    // Train the SentencePiece model
    const auto status = sentencepiece::SentencePieceTrainer::Train(command.str());
    ABORT_IF(!status.ok(),
             "SentencePiece vocabulary error: {}",
             status.ToString());

    LOG(info, "[SentencePiece] Removing {}", vocabPath + ".vocab");
    ABORT_IF(remove((vocabPath + ".vocab").c_str()) != 0,
             "Could not remove {}",
             vocabPath + ".vocab");

    LOG(info, "[SentencePiece] Renaming {} to {}", vocabPath + ".model", vocabPath);
    ABORT_IF(rename((vocabPath + ".model").c_str(), vocabPath.c_str()) != 0,
             "Could not rename {} to {}",
             vocabPath + ".model", vocabPath);
  }

  void createFake() override {
    ABORT("[SentencePiece] Fake SentencePiece vocabulary not supported");
  }

  Word operator[](const std::string& token) const override {
    return (Word)spm_->PieceToId(token);
  }

  const std::string& operator[](Word id) const override {
    ABORT_IF(id >= size(), "Unknown word id: ", id);
    return spm_->IdToPiece(id);
  }

  Words encode(const std::string& line, bool addEOS, bool inference) const override {
    std::vector<int> spmIds;
    if(inference || alpha_ == 0)
      spm_->Encode(line, &spmIds);
    else
      spm_->SampleEncode(line, -1, alpha_, &spmIds);

    Words words(spmIds.begin(), spmIds.end());

    if(addEOS)
      words.push_back(getEosId());
    return words;
  }

  std::string decode(const Words& sentence, bool /*ignoreEOS*/) const override {
    std::string line;
    // convert vector of Word to vector of int
    std::vector<int> spmSentence(sentence.begin(), sentence.end());
    spm_->Decode(spmSentence, &line);
    return line;
  }

  size_t size() const override {
    return spm_->GetPieceSize();
  }

  size_t load(const std::string& vocabPath, size_t /*maxSize*/) override {
    LOG(info, "[data] Loading SentencePiece vocabulary from file {}", vocabPath);

    ABORT_IF(!filesystem::exists(vocabPath),
             "SentencePiece vocabulary file {} does not exits",
             vocabPath);

    spm_.reset(new sentencepiece::SentencePieceProcessor());
    const auto status = spm_->Load(vocabPath);

    ABORT_IF(!status.ok(),
             "SentencePiece vocabulary error: {}",
             status.ToString());

    return spm_->GetPieceSize();
  }

};
#endif // USE_SENTENCEPIECE

Ptr<VocabBase> createSentencePieceVocab(const std::string& vocabPath, Ptr<Options> options, size_t batchIndex) {
  bool isSentencePiece = regex::regex_search(vocabPath, regex::regex("\\.(spm)$"));
  if(isSentencePiece) {
#ifdef USE_SENTENCEPIECE
    return New<SentencePieceVocab>(options, batchIndex);
#else
    batchIndex; options;
    ABORT("*.spm suffix in path {} reserved for SentencePiece models, "
          "but support for SentencePiece is not compiled into Marian. "
          "Try to recompile after `cmake .. -DUSE_SENTENCEPIECE=on [...]`",
          vocabPath);
#endif
  }
  // Not a SentencePiece model based on suffix;
  return nullptr;
}

}
