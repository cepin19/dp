#include "data/vocab_base.h"

#include "3rd_party/yaml-cpp/yaml.h"
#include "common/logging.h"
#include "common/regex.h"
#include "common/utils.h"
#include "common/filesystem.h"

#include <algorithm>
#include <fstream>
#include <iostream>
#include <sstream>
#include <unordered_map>
#include <unordered_set>

namespace marian {

class DefaultVocab : public VocabBase {
protected:
  typedef std::map<std::string, Word> Str2Id;
  Str2Id str2id_;

  typedef std::vector<std::string> Id2Str;
  Id2Str id2str_;

  Word eosId_ = (Word)-1;
  Word unkId_ = (Word)-1;

  std::vector<std::string> suffixes_ = { ".yml", ".yaml", ".json" };

  class VocabFreqOrderer {
  private:
    const std::unordered_map<std::string, size_t>& counter_;

  public:
    VocabFreqOrderer(const std::unordered_map<std::string, size_t>& counter)
            : counter_(counter) {}

    // order first by decreasing frequency,
    // if frequencies are the same order lexicographically by vocabulary string
    bool operator()(const std::string& a, const std::string& b) const {
      return counter_.at(a) > counter_.at(b) || (counter_.at(a) == counter_.at(b) && a < b);
    }
  };

public:
  virtual const std::string& canonicalExtension() const override { return suffixes_[0]; }
  virtual const std::vector<std::string>& suffixes() const override { return suffixes_; }

  virtual Word operator[](const std::string& word) const override {
    auto it = str2id_.find(word);
    if(it != str2id_.end())
      return it->second;
    else
      return unkId_;
  }

  Words encode(const std::string& line, bool addEOS, bool /*inference*/) const override {
    auto lineTokens = utils::split(line, " ");
    return (*this)(lineTokens, addEOS);
  }

  std::string decode(const Words& sentence, bool ignoreEOS) const override {
    std::string line;
    auto tokens = (*this)(sentence, ignoreEOS);
    return utils::join(tokens, " ");
  }

  virtual std::string type() const override { return "DefaultVocab"; }

  virtual Word getEosId() const override { return eosId_; }
  virtual Word getUnkId() const override { return unkId_; }


  const std::string& operator[](Word id) const override {
    ABORT_IF(id >= id2str_.size(), "Unknown word id: {}", id);
    return id2str_[id];
  }

  size_t size() const override {
    return id2str_.size();
  }

  size_t load(const std::string& vocabPath, size_t maxSize) override {
    bool isJson = regex::regex_search(vocabPath, regex::regex("\\.(json|yaml|yml)$"));
    LOG(info,
        "[data] Loading vocabulary from {} file {}",
        isJson ? "JSON/Yaml" : "text",
        vocabPath);
    ABORT_IF(!filesystem::exists(vocabPath),
            "DefaultVocabulary file {} does not exits",
            vocabPath);

    std::map<std::string, Word> vocab;
    // read from JSON (or Yaml) file
    if(isJson) {
      YAML::Node vocabNode = YAML::Load(io::InputFileStream(vocabPath));
      for(auto&& pair : vocabNode)
        vocab.insert({pair.first.as<std::string>(), pair.second.as<Word>()});
    }
    // read from flat text file
    else {
      io::InputFileStream in(vocabPath);
      std::string line;
      while(io::getline(in, line)) {
        ABORT_IF(line.empty(),
                "DefaultVocabulary file {} must not contain empty lines",
                vocabPath);
        auto wasInserted = vocab.insert({line, (Word)vocab.size()}).second;
        ABORT_IF(!wasInserted, "Duplicate vocabulary entry {}", line);

      }
      ABORT_IF(in.bad(), "DefaultVocabulary file {} could not be read", vocabPath);
    }

    id2str_.reserve(vocab.size());
    for(auto&& pair : vocab) {
      auto str = pair.first;
      auto id = pair.second;

      // note: this requires ids to be sorted by frequency
      if(!maxSize || id < (Word)maxSize) {
        insertWord(id, str);
      }
    }
    ABORT_IF(id2str_.empty(), "Empty vocabulary: ", vocabPath);

    addRequiredVocabulary(vocabPath, isJson);

    return std::max(id2str_.size(), maxSize);
  }

  // for fakeBatch()
  virtual void createFake() override {
    eosId_ = insertWord(DEFAULT_EOS_ID, DEFAULT_EOS_STR);
    unkId_ = insertWord(DEFAULT_UNK_ID, DEFAULT_UNK_STR);
  }

  virtual void create(const std::string& vocabPath,
                      const std::vector<std::string>& trainPaths,
                      size_t maxSize = 0) override {

    LOG(info, "[data] Creating vocabulary {} from {}",
              vocabPath,
              utils::join(trainPaths, ", "));

    if(vocabPath != "stdout") {
      filesystem::Path path(vocabPath);
      auto dir = path.parentPath();
      if(dir.empty())
        dir = filesystem::currentPath();

      ABORT_IF(!dir.empty() && !filesystem::isDirectory(dir),
              "Specified vocab directory {} does not exist",
              dir.string());

      ABORT_IF(filesystem::exists(vocabPath),
              "Vocabulary file '{}' exists. Not overwriting",
              path.string());
    }

    std::unordered_map<std::string, size_t> counter;
    for(const auto& trainPath : trainPaths)
      addCounts(counter, trainPath);
    create(vocabPath, counter, maxSize);
  }

private:

  virtual void addRequiredVocabulary(const std::string& vocabPath, bool isJson) {
    // look up ids for </s> and <unk>, which are required
    // The name backCompatStr is alternatively accepted for Yaml vocabs if id
    // equals backCompatId.
    auto getRequiredWordId = [&](const std::string& str,
                                const std::string& backCompatStr,
                                Word backCompatId) {
      // back compat with Nematus Yaml dicts
      if(isJson) {
        // if word id 0 or 1 is either empty or has the Nematus-convention string,
        // then use it
        if(backCompatId < id2str_.size()
          && (id2str_[backCompatId].empty()
              || id2str_[backCompatId] == backCompatStr)) {
          LOG(info,
              "[data] Using unused word id {} for {}",
              backCompatStr,
              backCompatId,
              str);
          return backCompatId;
        }
      }
      auto iter = str2id_.find(str);
      ABORT_IF(iter == str2id_.end(),
              "DefaultVocabulary file {} is expected to contain an entry for {}",
              vocabPath,
              str);
      return iter->second;
    };
    eosId_ = getRequiredWordId(DEFAULT_EOS_STR, NEMATUS_EOS_STR, DEFAULT_EOS_ID);
    unkId_ = getRequiredWordId(DEFAULT_UNK_STR, NEMATUS_UNK_STR, DEFAULT_UNK_ID);
  }

  void addCounts(std::unordered_map<std::string, size_t>& counter,
                 const std::string& trainPath) {
    std::unique_ptr<io::InputFileStream> trainStrm(
      trainPath == "stdin" ? new io::InputFileStream(std::cin)
                           : new io::InputFileStream(trainPath)
    );

    std::string line;
    while(getline(*trainStrm, line)) {
      auto toks = utils::split(line, " ");

      for(const std::string& tok : toks) {
        auto iter = counter.find(tok);
        if(iter == counter.end())
          counter[tok] = 1;
        else
          iter->second++;
      }
    }
  }

  virtual void create(const std::string& vocabPath,
                      const std::unordered_map<std::string, size_t>& counter,
                      size_t maxSize = 0) {

    std::vector<std::string> vocabVec;
    for(auto& p : counter)
      vocabVec.push_back(p.first);

    std::sort(vocabVec.begin(), vocabVec.end(), VocabFreqOrderer(counter));

    YAML::Node vocabYaml;
    vocabYaml.force_insert(DEFAULT_EOS_STR, DEFAULT_EOS_ID);
    vocabYaml.force_insert(DEFAULT_UNK_STR, DEFAULT_UNK_ID);

    Word maxSpec = 1;
    auto vocabSize = vocabVec.size();
    if(maxSize > maxSpec)
      vocabSize = std::min(maxSize - maxSpec - 1, vocabVec.size());

    for(size_t i = 0; i < vocabSize; ++i)
      vocabYaml.force_insert(vocabVec[i], i + maxSpec + 1);

    std::unique_ptr<io::OutputFileStream> vocabStrm(
      vocabPath == "stdout" ? new io::OutputFileStream(std::cout)
                            : new io::OutputFileStream(vocabPath)
    );
    *vocabStrm << vocabYaml;
  }

  Words operator()(const std::vector<std::string>& lineTokens,
                   bool addEOS) const {
    Words words(lineTokens.size());
    std::transform(lineTokens.begin(),
                  lineTokens.end(),
                  words.begin(),
                  [&](const std::string& w) { return (*this)[w]; });
    if(addEOS)
      words.push_back(eosId_);
    return words;
  }

  std::vector<std::string> operator()(const Words& sentence,
                                      bool ignoreEOS) const {
    std::vector<std::string> decoded;
    for(size_t i = 0; i < sentence.size(); ++i) {
      if((sentence[i] != eosId_ || !ignoreEOS)) {
        decoded.push_back((*this)[sentence[i]]);
      }
    }
    return decoded;
  }

  // helper to insert a word into str2id_[] and id2str_[]
  Word insertWord(Word id, const std::string& str) {
    str2id_[str] = id;
    if(id >= id2str_.size())
      id2str_.resize(id + 1);
    id2str_[id] = str;
    return id;
  };
};

// This is a vocabulary class that does not enforce </s> or <unk>.
// This is used for class lists in a classifier.
class ClassVocab : public DefaultVocab {
private:
  // Do nothing.
  virtual void addRequiredVocabulary(const std::string& vocabPath, bool isJson) override { vocabPath; isJson; }

  // Not adding special class labels, only seen classes.
  virtual void create(const std::string& vocabPath,
                      const std::unordered_map<std::string, size_t>& counter,
                      size_t maxSize = 0) override {

    std::vector<std::string> vocabVec;
    for(auto& p : counter)
      vocabVec.push_back(p.first);
    std::sort(vocabVec.begin(), vocabVec.end(), VocabFreqOrderer(counter));

    ABORT_IF(maxSize != 0 && vocabVec.size() != maxSize,
             "Class vocab maxSize given ({}) has to match class vocab size ({})",
             maxSize, vocabVec.size());

    YAML::Node vocabYaml;
    for(size_t i = 0; i < vocabVec.size(); ++i)
      vocabYaml.force_insert(vocabVec[i], i);

    std::unique_ptr<io::OutputFileStream> vocabStrm(
      vocabPath == "stdout" ? new io::OutputFileStream(std::cout)
                            : new io::OutputFileStream(vocabPath)
    );
    *vocabStrm << vocabYaml;
  }
};

Ptr<VocabBase> createDefaultVocab() {
  return New<DefaultVocab>();
}

Ptr<VocabBase> createClassVocab() {
  return New<ClassVocab>();
}

}
