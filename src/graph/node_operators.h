#pragma once

#include "graph/node.h"
#include "graph/node_initializers.h"
#include "tensors/tensor.h"

namespace marian {

struct ConstantNode : public Node {
  ConstantNode(Ptr<ExpressionGraph> graph,
               const Shape& shape,
               const NodeInitializer& init,
               Type value_type = Type::float32)
      : Node(graph, shape, value_type),
        init_(new NodeInitializer(init)),
        initialized_(false) {
    setTrainable(false);
  }

  ~ConstantNode() {}

  virtual size_t allocate() override;
  virtual void init() override;

  const std::string type() override { return "const"; }

  const std::string form() override { return "diamond"; }

  const std::string color() override { return "white"; }

  virtual size_t hash() override {
    size_t seed = util::hash<size_t>()((size_t)this);
    return seed;
  }

  virtual bool equal(Expr node) override { return this == node.get(); }
  virtual void record(Ptr<AutoTunerRecorder>, size_t, bool) override{};

private:
  UPtr<NodeInitializer> init_;
  bool initialized_;
};

struct ParamNode : public Node {
  ParamNode(Ptr<ExpressionGraph> graph,
            const Shape& shape,
            const NodeInitializer& init,
            bool fixed = false);

  ~ParamNode() {}

  virtual size_t allocate() override {
    ABORT_IF(!val_, "Parameters should be allocated by their graph. Parameter {} was not", name_);
    return 0;
  }

  virtual void init() override;

  const std::string type() override { return "param"; }

  const std::string form() override { return "hexagon"; }

  const std::string color() override { return "orangered"; }

  virtual size_t hash() override {
    size_t seed = util::hash<size_t>()((size_t)this);
    return seed;
  }

  virtual bool equal(Expr node) override { return name() == node->name(); }

  virtual void record(Ptr<AutoTunerRecorder>, size_t, bool) override{};

private:
  UPtr<NodeInitializer> init_;
  bool initialized_;
};
}  // namespace marian
