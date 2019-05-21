#pragma once

#include <string>
#include "marian.h"
#include "layers/loss.h"

namespace marian {
namespace models {

enum struct usage { raw, training, scoring, translation };
}
}  // namespace marian

YAML_REGISTER_TYPE(marian::models::usage, int)

namespace marian {
namespace models {

class ModelBase {
public:
  virtual void load(Ptr<ExpressionGraph>,
                    const std::string&,
                    bool markReloaded = true)
      = 0;
  virtual void save(Ptr<ExpressionGraph>,
                    const std::string&,
                    bool saveTranslatorConfig = false)
      = 0;

  virtual Ptr<RationalLoss> build(Ptr<ExpressionGraph> graph,
                                  Ptr<data::Batch> batch,
                                  bool clearGraph = true)
      = 0;

  virtual void clear(Ptr<ExpressionGraph> graph) = 0;
};

}  // namespace models
}  // namespace marian
