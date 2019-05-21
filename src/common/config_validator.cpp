#include "common/config_validator.h"
#include "common/logging.h"
#include "common/regex.h"
#include "common/utils.h"
#include "common/filesystem.h"

namespace marian {

bool ConfigValidator::has(const std::string& key) const {
  return config_[key];
}

ConfigValidator::ConfigValidator(const YAML::Node& config) : config_(config) {}

ConfigValidator::~ConfigValidator() {}

void ConfigValidator::validateOptions(cli::mode mode) const {
  // clang-format off
  switch(mode) {
    case cli::mode::translation:
      validateOptionsTranslation();
      break;
    case cli::mode::scoring:
      validateOptionsParallelData();
      validateOptionsScoring();
      break;
    case cli::mode::training:
      validateOptionsParallelData();
      validateOptionsTraining();
      break;
    default:
      ABORT("wrong CLI mode");
      break;
  }
  // clang-format on

  validateModelExtension(mode);
  validateDevices(mode);
}

void ConfigValidator::validateOptionsTranslation() const {
  auto models = get<std::vector<std::string>>("models");
  auto configs = get<std::vector<std::string>>("config");

  ABORT_IF(models.empty() && configs.empty(),
           "You need to provide at least one model file or a config file");

  auto vocabs = get<std::vector<std::string>>("vocabs");
  ABORT_IF(vocabs.empty(), "Translating, but vocabularies are not given!");

  for(const auto& modelFile : models) {
    filesystem::Path modelPath(modelFile);
    ABORT_IF(!filesystem::exists(modelPath), "Model file does not exist: " + modelFile);
  }
}

void ConfigValidator::validateOptionsParallelData() const {
  auto trainSets = get<std::vector<std::string>>("train-sets");
  ABORT_IF(trainSets.empty(), "No train sets given in config file or on command line");

  auto vocabs = get<std::vector<std::string>>("vocabs");
  ABORT_IF(!vocabs.empty() && vocabs.size() != trainSets.size(),
           "There should be as many vocabularies as training sets");
}

void ConfigValidator::validateOptionsScoring() const {
  filesystem::Path modelPath(get<std::string>("model"));

  ABORT_IF(!filesystem::exists(modelPath), "Model file does not exist: " + modelPath.string());
  ABORT_IF(get<std::vector<std::string>>("vocabs").empty(),
           "Scoring, but vocabularies are not given!");
}

void ConfigValidator::validateOptionsTraining() const {
  auto trainSets = get<std::vector<std::string>>("train-sets");

  ABORT_IF(has("embedding-vectors")
               && get<std::vector<std::string>>("embedding-vectors").size() != trainSets.size()
               && !get<std::vector<std::string>>("embedding-vectors").empty(),
           "There should be as many embedding vector files as training sets");

  filesystem::Path modelPath(get<std::string>("model"));

  auto modelDir = modelPath.parentPath();
  if(modelDir.empty())
    modelDir = filesystem::currentPath();

  ABORT_IF(!modelDir.empty() && !filesystem::isDirectory(modelDir),
           "Model directory does not exist");

  ABORT_IF(has("valid-sets")
               && get<std::vector<std::string>>("valid-sets").size() != trainSets.size()
               && !get<std::vector<std::string>>("valid-sets").empty(),
           "There should be as many validation sets as training sets");

  // validations for learning rate decaying
  ABORT_IF(get<float>("lr-decay") > 1.f, "Learning rate decay factor greater than 1.0 is unusual");

  auto strategy = get<std::string>("lr-decay-strategy");

  ABORT_IF((strategy == "epoch+batches" || strategy == "epoch+stalled")
               && get<std::vector<size_t>>("lr-decay-start").size() != 2,
           "Decay strategies 'epoch+batches' and 'epoch+stalled' require two values specified with "
           "--lr-decay-start option");
  ABORT_IF((strategy == "epoch" || strategy == "batches" || strategy == "stalled")
               && get<std::vector<size_t>>("lr-decay-start").size() != 1,
           "Single decay strategies require only one value specified with --lr-decay-start option");

  // validate ULR options
  ABORT_IF((has("ulr") && get<bool>("ulr") && (get<std::string>("ulr-query-vectors") == ""
                                               || get<std::string>("ulr-keys-vectors") == "")),
           "ULR enablign requires query and keys vectors specified with --ulr-query-vectors and "
           "--ulr-keys-vectors option");
}

void ConfigValidator::validateModelExtension(cli::mode mode) const {
  std::vector<std::string> models;
  if(mode == cli::mode::translation)
    models = get<std::vector<std::string>>("models");
  else
    models.push_back(get<std::string>("model"));

  for(const auto& modelPath : models) {
    bool hasProperExt = utils::endsWith(modelPath, ".npz") || utils::endsWith(modelPath, ".bin");
    ABORT_IF(!hasProperExt,
             "Unknown model format for file '{}'. Supported file extensions: .npz, .bin",
             modelPath);
  }
}

void ConfigValidator::validateDevices(cli::mode mode) const {
  std::string devices = utils::join(get<std::vector<std::string>>("devices"));
  utils::trim(devices);

  regex::regex pattern;
  std::string help;
  // @TODO: Is this format still supported? Remove this if not.
  if(mode == cli::mode::training && get<bool>("multi-node")) {
    // valid strings: '0: 1 2', '0:1 2 1:2 3'
    pattern = "( *[0-9]+ *: *[0-9]+( *[0-9]+)*)+";
    help = "Supported format for multi-node setting: '0:0 1 2 3 1:0 1 2 3'";
  } else {
    // valid strings: '0', '0 1 2 3', '3 2 0 1'
    pattern = "[0-9]+( *[0-9]+)*";
    help = "Supported formats: '0 1 2 3'";
  }

  ABORT_IF(!regex::regex_match(devices, pattern),
           "the argument '{}' for option '--devices' is invalid. {}",
           devices,
           help);
}

}  // namespace marian
