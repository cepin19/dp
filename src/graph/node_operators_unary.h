#pragma once

#include "tensors/backend.h"
#include "tensors/tensor.h"

#include "functional/functional.h"
#include "graph/node.h"
#include "tensors/tensor_operators.h"

#ifdef CUDNN
#include "tensors/gpu/cudnn_wrappers.h"
#endif

namespace marian {

struct UnaryNodeOp : public NaryNodeOp {
  UnaryNodeOp(Expr a, Shape shape, Type value_type = Type::float32)
      : NaryNodeOp({a}, shape, value_type) {}

  UnaryNodeOp(Expr a, Type value_type = Type::float32)
      : NaryNodeOp({a}, a->shape(), value_type) {}

  const std::string color() override { return "yellow"; }
};

struct ScalarAddNodeOp : public UnaryNodeOp {
private:
  float scalar_{0};

public:
  ScalarAddNodeOp(Expr a, float scalar) : UnaryNodeOp(a), scalar_{scalar} {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = _2 + scalar_, val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    return {NodeOp(Add(_1, child(0)->grad(), adj_))};
  }

  const std::string type() override { return "scalar_add"; }

  virtual size_t hash() override {
    if(!hash_) {
      hash_ = NaryNodeOp::hash();
      util::hash_combine(hash_, scalar_);
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    auto cnode = std::dynamic_pointer_cast<ScalarAddNodeOp>(node);
    if(!cnode)
      return false;
    if(scalar_ != cnode->scalar_)
      return false;
    return true;
  }
};

struct ScalarMultNodeOp : public UnaryNodeOp {
private:
  float scalar_{0};

public:
  ScalarMultNodeOp(Expr a, float scalar) : UnaryNodeOp(a), scalar_{scalar} {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = scalar_ * _2, val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    return {NodeOp(Add(scalar_ * _1, child(0)->grad(), adj_))};
  }

  const std::string type() override { return "scalar_mult"; }

  virtual size_t hash() override {
    if(!hash_) {
      hash_ = NaryNodeOp::hash();
      util::hash_combine(hash_, scalar_);
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    auto cnode = std::dynamic_pointer_cast<ScalarMultNodeOp>(node);
    if(!cnode)
      return false;
    if(scalar_ != cnode->scalar_)
      return false;
    return true;
  }
};

struct ClipNodeOp : public UnaryNodeOp {
private:
  float clip_{0};

public:
  ClipNodeOp(Expr a, float clip) : UnaryNodeOp(a), clip_{clip} {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = clip(_2, clip_), val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    return {NodeOp(
        Add(bump(_1, clip_) * _2, child(0)->grad(), child(0)->val(), adj_))};
  }

  const std::string type() override { return "clip"; }

  virtual size_t hash() override {
    if(!hash_) {
      hash_ = NaryNodeOp::hash();
      util::hash_combine(hash_, clip_);
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    auto cnode = std::dynamic_pointer_cast<ClipNodeOp>(node);
    if(!cnode)
      return false;
    if(clip_ != cnode->clip_)
      return false;
    return true;
  }
};

struct SigmoidNodeOp : public UnaryNodeOp {
  SigmoidNodeOp(Expr a) : UnaryNodeOp(a) {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = sigmoid(_2), val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    return {NodeOp(Add(_1 * _2 * (1.0f - _2), child(0)->grad(), adj_, val_))};
  }

  const std::string type() override { return "sigmoid"; }
};

// struct Scalar2PowNodeOp : public UnaryNodeOp {
// private:
//  float scalar_{0};
//
// public:
//  template <typename... Args>
//  Scalar2PowNodeOp(Expr a, float scalar, Args... args)
//      : UnaryNodeOp(a, args...), scalar_{scalar} {}
//
//  NodeOps forwardOps() {
//    return {NodeOp(Element(_1 = Pow(_2, scalar_), val_, child(0)->val()))};
//  }
//
//  NodeOps backwardOps() {
//    return {NodeOp(Add(scalar_ * Pow(_1, scalar_ - 1.f) * _2,
//    child(0)->grad(), child(0)->val(), adj_))};
//  }
//
//  const std::string type() { return "scalar_pow2"; }
//};
//
// struct Scalar1PowNodeOp : public UnaryNodeOp {
// private:
//  float scalar_{0};
//
// public:
//  template <typename... Args>
//  Scalar1PowNodeOp(float scalar, Expr a, Args... args)
//      : UnaryNodeOp(a, args...), scalar_{scalar} {}
//
//  NodeOps forwardOps() {
//    return {NodeOp(Element(_1 = Pow(scalar_, _2), val_, child(0)->val()))};
//  }
//
//  NodeOps backwardOps() {
//    return {NodeOp(Add(Pow(scalar_, _1) * log(scalar_) * _2, child(0)->grad(),
//    child(0)->val(), adj_))};
//  }
//
//  const std::string type() { return "scalar_pow1"; }
//};

struct TanhNodeOp : public NaryNodeOp {
  TanhNodeOp(const std::vector<Expr>& nodes)
      : NaryNodeOp(nodes, newShape(nodes)) {}

  Shape newShape(const std::vector<Expr>& nodes) {
    return Shape::broadcast(nodes);
  }

  NodeOps forwardOps() override {
    using namespace functional;
    switch(children_.size()) {
      case 1: return {NodeOp(Element(_1 = tanh(_2), val_, child(0)->val()))};
      case 2:
        return {NodeOp(Element(
            _1 = tanh(_2 + _3), val_, child(0)->val(), child(1)->val()))};
      case 3:
        return {NodeOp(Element(_1 = tanh(_2 + _3 + _4),
                               val_,
                               child(0)->val(),
                               child(1)->val(),
                               child(2)->val()))};
      default:
        return {
          NodeOp(Element(_1 = _2 + _3 + _4,
                         val_,
                         child(0)->val(),
                         child(1)->val(),
                         child(2)->val());
                 for(size_t i = 3; i < children_.size(); ++i)
                     Element(_1 = _1 + _2, val_, child(i)->val());
                 Element(_1 = tanh(_1), val_);)
        };
    }
  }

  NodeOps backwardOps() override {
    using namespace functional;
    NodeOps ops;
    for(size_t i = 0; i < children_.size(); i++) {
      ops.push_back(
          NodeOp(Add(_1 * (1.0f - (_2 * _2)), child(i)->grad(), adj_, val_)));
    }
    return ops;
  }

  const std::string color() override { return "yellow"; }

  const std::string type() override { return "tanh"; }
};

struct ReLUNodeOp : public UnaryNodeOp {
  ReLUNodeOp(Expr a) : UnaryNodeOp(a) {}

  NodeOps forwardOps() override {
    // f(x) = max(0, x)
    using namespace functional;
    return {NodeOp(Element(_1 = ReLU(_2),
                           val_,            // _1 := f(x) to be calculated
                           child(0)->val()  // _2 := x
                           ))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    // dJ/dx += dJ/df * binarystep(x)
    return {NodeOp(Add(_1 * ReLUback(_2),
                       child(0)->grad(),  // dJ/dx
                       adj_,              // _1 := dJ/df
                       child(0)->val()    // _2 := f(x) = max(0, x)
                       ))};
  }

  const std::string type() override { return "ReLU"; }
};

/**
 * Represents a <a
 * href="https://en.wikipedia.org/wiki/Rectifier_(neural_networks)">parametric
 * rectified linear unit</a> node in an expression graph.
 * For \f$ \alpha = 0.01 \f$ (the default value) it is equivalent to Leaky
 * ReLU.
 *
 * This node implements the activation function:
 * \f[
 *   f(x, \alpha) =
 *   \begin{cases}
 *     \alpha x & \text{if } x \leq 0 \\
 *     x        & \text{if } x > 0
 *   \end{cases}
 * \f]
 *
 * and its derivative:
 * \f[
 *   f^\prime(x, \alpha) =
 *   \begin{cases}
 *     \alpha & \text{if } x \leq 0 \\
 *     1      & \text{if } x > 0
 *   \end{cases}
 * \f]
 */
struct PReLUNodeOp : public UnaryNodeOp {
  PReLUNodeOp(float alpha, Expr a) : UnaryNodeOp(a), alpha_(alpha) {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = PReLU(_2, alpha_), val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    return {NodeOp(Add(
        _1 * PReLUback(_2, alpha_), child(0)->grad(), adj_, child(0)->val()))};
  }

  const std::string type() override { return "PReLU"; }

  virtual size_t hash() override {
    if(!hash_) {
      hash_ = NaryNodeOp::hash();
      util::hash_combine(hash_, alpha_);
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    auto cnode = std::dynamic_pointer_cast<PReLUNodeOp>(node);
    if(!cnode)
      return false;
    if(alpha_ != cnode->alpha_)
      return false;
    return true;
  }

private:
  float alpha_{0.01f};
};

/**
 * Represents a <a href="https://arxiv.org/pdf/1710.05941.pdf">swish</a> node
 * in an expression graph.
 *
 * This node implements the activation function
 * \f$ f(x) = x \cdot \sigma(bx) \f$
 * and its derivative
 * \f$ f^\prime(x) = bf(x) + \sigma(bx)(1 - bf(x)) \f$ .
 *
 */
struct SwishNodeOp : public UnaryNodeOp {
  SwishNodeOp(Expr a, float b = 1.f) : UnaryNodeOp(a), b_{b} {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = _2 * sigmoid(b_ * _2), val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    // dJ/dx += dJ/df * (b*f(x) + sigmoid(b*x) * (1 - b*f(x)))
    return {NodeOp(Add(_1 * (b_ * _3 + sigmoid(b_ * _2) * (1.f - (b_ * _3))),
                       child(0)->grad(),  // dJ/dx
                       adj_,              // _1 := dJ/df
                       child(0)->val(),   // _2 := x
                       val_               // _3 := f(x) = x*sigmoid(b*x)
                       ))};
  }

  const std::string type() override { return "swish"; }

  virtual size_t hash() override {
    if(!hash_) {
      hash_ = NaryNodeOp::hash();
      util::hash_combine(hash_, b_);
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    Ptr<SwishNodeOp> cnode = std::dynamic_pointer_cast<SwishNodeOp>(node);
    if(!cnode)
      return false;
    if(b_ != cnode->b_)
      return false;
    return true;
  }

  float b_;
};

struct SoftmaxNodeOp : public UnaryNodeOp {
  SoftmaxNodeOp(Expr a) : UnaryNodeOp(a) {}

  NodeOps forwardOps() override {
    return {
        NodeOp(Softmax(val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    // For each row, the Jacobian times vector is given by:
    // J * dy = p .* (dy - avg*1)
    // where avg = p'*dy and p is the softmax output (probabilities).
    //
    // For more information, see sec. 2.5 of the following reference:
    // André F. T. Martins and Ramon Astudillo.
    // "From Softmax to Sparsemax: A Sparse Model of Attention and Multi-Label
    // Classification." ICML 2016.
    // http://jmlr.org/proceedings/papers/v48/martins16.pdf

    // val_ is already masked if there is a mask, so no need to apply here.

    return {NodeOp(SoftmaxGrad(child(0)->grad(), adj_, val_))};
  }

  const std::string type() override { return "softmax"; }
};

struct LogSoftmaxNodeOp : public UnaryNodeOp {
  LogSoftmaxNodeOp(Expr a) : UnaryNodeOp(a) {}

  NodeOps forwardOps() override { return {NodeOp(LogSoftmax(val_, child(0)->val()))}; }

  NodeOps backwardOps() override {
    // Based on the description for softmax, we have logsoftmax:
    // J * dy = dy - avg*1
    // where avg = exp(p)'*dy and p is the softmax output (probabilities).
    return {NodeOp(LogSoftmaxGrad(child(0)->grad(), adj_, val_))};
  }

  const std::string type() override { return "logsoftmax"; }
};

enum class ReduceNodeOpCode {
  sum, mean, rms, meanSqr, min, max, prod, logSumExp
};

struct ReduceNodeOp : public UnaryNodeOp {
  int axis_;
  ReduceNodeOpCode opCode_;
  int reducedDim_; // dimension of axis being reduced, e.g. used in mean()

  ReduceNodeOp(Expr a, int axis, ReduceNodeOpCode opCode)
      : UnaryNodeOp(a, newShape(a, axis)), opCode_(opCode)
  {
    reducedDim_ = a->shape()[axis]; // e.g. used in mean()
    ABORT_IF(reducedDim_ != a->shape().elements() / shape().elements(), "bug in determining reducedDim");
  }

  NodeOps forwardOps() override {
    using namespace functional;

    switch (opCode_) {
    case ReduceNodeOpCode::sum:
      return {NodeOp(Reduce(_1, val_, child(0)->val()))};
    case ReduceNodeOpCode::mean:
      return {NodeOp(Reduce(_1, 1.0f / (float)reducedDim_, val_, child(0)->val()))};
    case ReduceNodeOpCode::rms:
      return {NodeOp(Reduce(_1 * _1, 1.0f / (float)reducedDim_, val_, child(0)->val());
                     Element(_1 = sqrt(_1), val_))};
    case ReduceNodeOpCode::meanSqr:
      return {NodeOp(Reduce(_1 * _1, 1.0f / (float)reducedDim_, val_, child(0)->val()))};
    case ReduceNodeOpCode::min:
      return {NodeOp(Reduce(_1, min(_1,_2), std::numeric_limits<float>::max(), val_, child(0)->val()))};
    case ReduceNodeOpCode::max:
      return {NodeOp(Reduce(_1, max(_1,_2), std::numeric_limits<float>::lowest(), val_, child(0)->val()))};
    case ReduceNodeOpCode::prod:
      return {NodeOp(Reduce(_1, _1 * _2, 1.0f, val_, child(0)->val()))};
    case ReduceNodeOpCode::logSumExp:
      return {NodeOp(Reduce(_1, logaddexp(_1,_2), std::numeric_limits<float>::lowest(), val_, child(0)->val()))};
    default:
      ABORT("Unexpected reduction op-code {}", (int)opCode_);
    }
  }

  NodeOps backwardOps() override {
    using namespace functional;
    switch (opCode_) {
    case ReduceNodeOpCode::sum:
      return {NodeOp(Add(_1, child(0)->grad(), adj_))};
    case ReduceNodeOpCode::mean:
      return {NodeOp(Add(_1, 1.0f / (float)reducedDim_, child(0)->grad(), adj_))};
    case ReduceNodeOpCode::rms: // WARNING: UNTESTED!!
      // y = (sum_j x_j^2)^0.5
      // dJ/dx_i = dJ/dy * 0.5 (sum_j x_j^2)^-0.5 * 2 x_i = dJ/dy * x_i / y  --@REVIEW: is this correct?
      // @TODO: do we need protection against div by 0? L'hospital rule?
      return {NodeOp(Add(_1 * _2 / _3, child(0)->grad(), adj_, child(0)->val(), val_))};
    case ReduceNodeOpCode::meanSqr: // WARNING: UNTESTED!!
      // y = sum_j x_j^2
      // dJ/dx_i = dJ/dy * sum_j dx_j^2/dx_i = dJ/dy * 2 dx_i  --@REVIEW: is this correct?
      return {NodeOp(Add(_1 * 2.0f * _2, child(0)->grad(), adj_, child(0)->val()))};
    case ReduceNodeOpCode::min:  // WARNING: UNTESTED!!
    case ReduceNodeOpCode::max:  // WARNING: UNTESTED!!
      // adj_ gets routed into the min/max value  --@REVIEW: is this correct?
      return {NodeOp(Add((_1 == _2) * _3, child(0)->grad(), child(0)->val(), val_, adj_))};
    case ReduceNodeOpCode::logSumExp:
      // y = log(sum_j exp(x_j))
       // dJ/dx_i = dJ/dy * 1/(sum_j exp(x_j)) exp(x_i) = dJ/dy * exp(x_i - y))  --@REVIEW: is this correct?
      return {NodeOp(Add(_1 * exp(_2 - _3), child(0)->grad(), adj_, child(0)->val(), val_))};
    default:
      ABORT("Unexpected reduction op-code {}", (int)opCode_);
    }
  }

  Shape newShape(Expr a, int axis) {
    Shape shape = a->shape();
    axis_ = shape.axis(axis);

    shape.set(axis_, 1);
    return shape;
  }

  const std::string type() override {
    switch (opCode_) {
    case ReduceNodeOpCode::sum:       return "sum";
    case ReduceNodeOpCode::mean:      return "mean";
    case ReduceNodeOpCode::rms:       return "rms";
    case ReduceNodeOpCode::meanSqr:   return "meanSqr";
    case ReduceNodeOpCode::min:       return "min";
    case ReduceNodeOpCode::max:       return "max";
    case ReduceNodeOpCode::prod:      return "prod";
    case ReduceNodeOpCode::logSumExp: return "logSumExp";
    default: ABORT("Unexpected reduction op-code {}", (int)opCode_);
    }
  }

  const std::string color() override { return "orange"; }

  virtual size_t hash() override {
    if(!hash_) {
      hash_ = NaryNodeOp::hash();
      util::hash_combine(hash_, axis_);
      util::hash_combine(hash_, (int)opCode_);
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    Ptr<ReduceNodeOp> cnode = std::dynamic_pointer_cast<ReduceNodeOp>(node);
    if(!cnode)
      return false;
    if(axis_ != cnode->axis_ || opCode_ != cnode->opCode_)
      return false;
    return true;
  }
};

struct LogNodeOp : public UnaryNodeOp {
  LogNodeOp(Expr a) : UnaryNodeOp(a) {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = log(_2), val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    return {// NodeOp(Add(_1 * (1.f / _2), child(0)->grad(), adj_,
            // child(0)->val()))};
            NodeOp(Add(_1 / _2, child(0)->grad(), adj_, child(0)->val()))};
  }

  const std::string type() override { return "log"; }
};

struct ExpNodeOp : public UnaryNodeOp {
  ExpNodeOp(Expr a) : UnaryNodeOp(a) {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = exp(_2), val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    return {NodeOp(Add(_1 * exp(_2), child(0)->grad(), adj_, child(0)->val()))};
  }

  const std::string type() override { return "exp"; }
};

struct SqrtNodeOp : public UnaryNodeOp {
  float epsilon_;

  SqrtNodeOp(Expr a, float epsilon) : UnaryNodeOp(a), epsilon_(epsilon) {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = sqrt(_2 + epsilon_), val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    return {NodeOp(Add(0.5f * (1.f / _1) * _2, child(0)->grad(), val_, adj_))};
  }

  const std::string type() override { return "sqrt"; }

  virtual size_t hash() override {
    if(!hash_) {
      size_t seed = NaryNodeOp::hash();
      util::hash_combine(seed, epsilon_);
      hash_ = seed;
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    Ptr<SqrtNodeOp> cnode = std::dynamic_pointer_cast<SqrtNodeOp>(node);
    if(!cnode)
      return false;
    if(epsilon_ != cnode->epsilon_)
      return false;
    return true;
  }
};

struct SquareNodeOp : public UnaryNodeOp {
  SquareNodeOp(Expr a) : UnaryNodeOp(a) {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = _2 * _2, val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    return {
        NodeOp(Add(2.f * _1 * _2, child(0)->grad(), child(0)->val(), adj_))};
  }

  const std::string type() override { return "square"; }
};

struct NegNodeOp : public UnaryNodeOp {
  NegNodeOp(Expr a) : UnaryNodeOp(a) {}

  NodeOps forwardOps() override {
    using namespace functional;
    return {NodeOp(Element(_1 = -_2, val_, child(0)->val()))};
  }

  NodeOps backwardOps() override {
    using namespace functional;
    return {NodeOp(Add(-_1, child(0)->grad(), adj_))};
  }

  const std::string type() override { return "-"; }
};

struct TransposeNodeOp : public UnaryNodeOp {
  std::vector<int> axes_;
  std::vector<int> axesBw_;

  TransposeNodeOp(Expr a, const std::vector<int>& axes)
      : UnaryNodeOp(a, newShape(a, axes)), axes_{axes}, axesBw_(axes.size()) {
    for(int i = 0; i < axes_.size(); ++i)
       axesBw_[axes_[i]] = i;
  }

  NodeOps forwardOps() override {
    return {NodeOp(TransposeND(val_, child(0)->val(), axes_))};
  }

  NodeOps backwardOps() override {
    return {NodeOp(TransposeNDGrad(child(0)->grad(), adj_, axesBw_))};
  }

  Shape newShape(Expr a, const std::vector<int>& axes) {
    Shape shape = a->shape();

    ABORT_IF(shape.size() != axes.size(),
             "Shape and transpose axes have different number of dimensions");

    for(size_t i = 0; i < shape.size(); ++i)
      shape.set(i, a->shape()[axes[i]]);

    return shape;
  }

  virtual size_t hash() override {
    if(!hash_) {
      size_t seed = NaryNodeOp::hash();
      for(auto ax : axes_)
        util::hash_combine(seed, ax);
      hash_ = seed;
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    Ptr<TransposeNodeOp> cnode
        = std::dynamic_pointer_cast<TransposeNodeOp>(node);
    if(!cnode)
      return false;
    if(axes_ != cnode->axes_)
      return false;
    return true;
  }

  const std::string type() override { return "transpose"; }

  const std::string color() override { return "orange"; }
};

class ReshapeNodeOp : public UnaryNodeOp {
private:
  Expr reshapee_;

public:
  ReshapeNodeOp(Expr a, Shape shape) : UnaryNodeOp(a, shape, a->value_type()), reshapee_(a) {
    Node::destroy_ = false;
  }

  ~ReshapeNodeOp() {}

  size_t allocate() override { return 0; }
  void free() override {}

  void forward() override {}
  void backward() override {}

  void init_dependent() override { reshapee_->init_dependent(); }

  void set_zero_adjoint() override { reshapee_->set_zero_adjoint(); }

  Tensor& val() override {
    auto childVal = reshapee_->val();
    val_.reset(
        new TensorBase(childVal->memory(), shape(), childVal->type(), childVal->getBackend()));
    return val_;
  };

  Tensor& grad() override {
    auto childGrad = reshapee_->grad();
    adj_.reset(
        new TensorBase(childGrad->memory(), shape(), childGrad->type(), childGrad->getBackend()));
    return adj_;
  };

  const std::string type() override { return "reshape"; }

  const std::string color() override { return "grey"; }

  virtual size_t hash() override {
    if(!hash_) {
      size_t seed = NaryNodeOp::hash();
      for(auto s : shape())
        util::hash_combine(seed, s);
      hash_ = seed;
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    Ptr<ReshapeNodeOp> cnode = std::dynamic_pointer_cast<ReshapeNodeOp>(node);
    if(!cnode)
      return false;
    if(shape() != cnode->shape())
      return false;
    return true;
  }
};

// narrow an axis to [begin, end)
// The resulting object must be consecutive in memory.
class SliceViewNodeOp : public UnaryNodeOp {
private:
  Expr viewedNode_; // viewed underlying node
  Slice slice_;     // index range
  int axis_;        // and axis along which it is viewed
  size_t byteOffset_, byteSize_; // viewed segment in bytes (memory-consecutive)

public:
  SliceViewNodeOp(Expr a, int axis, Slice slice)
      : UnaryNodeOp(a, newShape(a, axis, slice), a->value_type()), viewedNode_(a), slice_(slice), axis_(axis) {
    Node::destroy_ = false;
    auto byteStride = a->shape().stride(axis) * sizeOf(value_type());
    byteOffset_ = slice.begin * byteStride;
    byteSize_ = shape()[axis] * byteStride;
  }

  static Shape newShape(Expr a, int& axis, Slice& slice) { // note: normalizes slice and axis in-place
    const auto& shape = a->shape();
    axis  = shape.axis(axis);         // normalize negative axis
    slice = shape.slice(slice, axis); // normalize negative slice values
    // enforce consecutive memory
    if (slice.begin != 0 || slice.end != shape[axis] || slice.stride != 1) { // unless it's a no-op
      ABORT_IF(slice.stride != 1, "Strides other than 1 are presently not supported by sliceView()");
      for(int i = 0; i < axis; ++i)
        ABORT_IF(shape[i] != 1, "Non-consecutive slices are presently not supported by sliceView()");
    }
    Shape outShape = shape;
    outShape.set(axis, slice.end - slice.begin);
    return outShape;
  }

  size_t allocate() override { return 0; }
  void free() override {}

  void forward() override {}
  void backward() override {}

  void init_dependent() override { viewedNode_->init_dependent(); }

  void set_zero_adjoint() override { viewedNode_->set_zero_adjoint(); } // lazily allocate and zero out gradient (only runs once)

  Tensor& val() override {
    auto childVal = viewedNode_->val();
    auto mem = New<MemoryPiece>(childVal->memory()->data() + byteOffset_, byteSize_);
    val_.reset(new TensorBase(mem, shape(), childVal->type(), childVal->getBackend()));
    return val_;
  };

  Tensor& grad() override {
    auto childGrad = viewedNode_->grad();
    auto mem = New<MemoryPiece>(childGrad->memory()->data() + byteOffset_, byteSize_);
    adj_.reset(new TensorBase(mem, shape(), childGrad->type(), childGrad->getBackend()));
    return adj_;
  };

  const std::string type() override { return "sliceView"; }

  const std::string color() override { return "grey"; }

  virtual size_t hash() override {
    if(!hash_) {
      hash_ = NaryNodeOp::hash();
      util::hash_combine(hash_, slice_.begin);
      util::hash_combine(hash_, slice_.end);
      util::hash_combine(hash_, slice_.stride);
      util::hash_combine(hash_, axis_);
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    Ptr<SliceViewNodeOp> cnode = std::dynamic_pointer_cast<SliceViewNodeOp>(node);
    if(!cnode)
      return false;
    if(slice_ != cnode->slice_)
      return false;
    if(axis_ != cnode->axis_)
      return false;
    return true;
  }
};

struct ShiftNodeOp : public UnaryNodeOp {
  ShiftNodeOp(Expr a, Shape shift, float padValue)
      : UnaryNodeOp(a, a->shape()), shift_(shift), padValue_(padValue) {}

  NodeOps forwardOps() override {
    return {NodeOp(
        Shift(val_, child(0)->val(), shift_, padValue_, /*invert=*/false))};
  }

  NodeOps backwardOps() override {
    // last parameter beta=1 says to use += (out = in + beta * out)
    // @TODO: check need for padValue_
    return {NodeOp(ShiftGrad(child(0)->grad(), adj_, shift_, true))};
  }

  const std::string type() override { return "shift"; }

  virtual size_t hash() override {
    if(!hash_) {
      size_t seed = NaryNodeOp::hash();
      for(auto i : shift_)
        util::hash_combine(seed, i);
      util::hash_combine(seed, padValue_);
      hash_ = seed;
    }
    return hash_;
  }

  virtual bool equal(Expr node) override {
    if(!NaryNodeOp::equal(node))
      return false;
    Ptr<ShiftNodeOp> cnode = std::dynamic_pointer_cast<ShiftNodeOp>(node);
    if(!cnode)
      return false;
    if(shift_ != cnode->shift_)
      return false;
    return true;
  }

  Shape shift_;     // shift offsets in each dimension
  float padValue_;  // what value to shift in
};

#ifdef CUDNN
class PoolingOp : public UnaryNodeOp {
public:
  PoolingOp(Expr x,
            int height,
            int width,
            int padHeight,
            int padWidth,
            int strideHeight,
            int strideWidth,
            std::string mode)
      : UnaryNodeOp(x),
        pooling_(height,
                 width,
                 padHeight,
                 padWidth,
                 strideHeight,
                 strideWidth,
                 mode) {}

  NodeOps forwardOps() override {
    return {NodeOp(pooling_.forward(child(0)->val(), val_))};
  }

  NodeOps backwardOps() override {
    return {NodeOp(
        pooling_.backward(child(0)->val(), child(0)->grad(), val_, adj_))};
  }

  const std::string type() override { return "layer_pooling"; }

protected:
  PoolingWrapper pooling_;
};
#endif

class PoolingWithMaskingOp : public UnaryNodeOp {
public:
  PoolingWithMaskingOp(Expr x, Expr mask, int width, bool isEven = false)
      : UnaryNodeOp(x), mask_(mask), width_(width), isEven_(isEven) {
    auto xShape = x->shape();
    int dimBatch = xShape[0];
    int dimWord = xShape[1];
    int cols = (isEven_) ? xShape[2] - 1 : xShape[2];
    int dimSentence = (cols / width_) + (cols % width_ != 0);
    shape_ = {dimBatch, dimWord, dimSentence};
  }

  NodeOps forwardOps() override {
    return {NodeOp(PoolingWithMaskingForward(
        val_, child(0)->val(), mask_->val(), width_, isEven_))};
  }

  NodeOps backwardOps() override {
    return {NodeOp(PoolingWithMaskingBackward(adj_,
                                              child(0)->grad(),
                                              child(0)->val(),
                                              mask_->val(),
                                              width_,
                                              isEven_))};
  }

  const std::string type() override { return "layer_pooling"; }

protected:
  Expr mask_;
  int width_;
  bool isEven_;
};
}  // namespace marian
