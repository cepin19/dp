#pragma once

#include "functional/array.h"
#include "functional/defs.h"
#include "functional/tensor.h"

namespace marian {
namespace functional {

template <size_t K, class Functor>
struct FApply {};

template <class Functor>
struct FApply<1, Functor> {
  __HDI__ static float apply(
      Functor functor,
      functional::Array<functional::Tensor<float>, 1>& in,
      const functional::Array<int, 1>& indices) {
    return functor(in[0][indices[0]]);
  }

  __HDI__ static float apply(
      Functor functor,
      functional::Array<functional::Tensor<float>, 1>& in,
      int index) {
    return functor(in[0][index]);
  }
};

template <class Functor>
struct FApply<2, Functor> {
  __HDI__ static float apply(
      Functor functor,
      functional::Array<functional::Tensor<float>, 2>& in,
      const functional::Array<int, 2>& indices) {
    return functor(in[0][indices[0]], in[1][indices[1]]);
  }

  __HDI__ static float apply(
      Functor functor,
      functional::Array<functional::Tensor<float>, 2>& in,
      int index) {
    return functor(in[0][index], in[1][index]);
  }
};

template <class Functor>
struct FApply<3, Functor> {
  __HDI__ static float apply(
      Functor functor,
      functional::Array<functional::Tensor<float>, 3>& in,
      const functional::Array<int, 3>& indices) {
    return functor(in[0][indices[0]], in[1][indices[1]], in[2][indices[2]]);
  }

  __HDI__ static float apply(
      Functor functor,
      functional::Array<functional::Tensor<float>, 3>& in,
      int index) {
    return functor(in[0][index], in[1][index], in[2][index]);
  }
};

template <class Functor>
struct FApply<4, Functor> {
  __HDI__ static float apply(
      Functor functor,
      functional::Array<functional::Tensor<float>, 4>& in,
      const functional::Array<int, 4>& indices) {
    return functor(in[0][indices[0]],
                   in[1][indices[1]],
                   in[2][indices[2]],
                   in[3][indices[3]]);
  }

  __HDI__ static float apply(
      Functor functor,
      functional::Array<functional::Tensor<float>, 4>& in,
      int index) {
    return functor(in[0][index], in[1][index], in[2][index], in[3][index]);
  }
};

template <class Functor>
struct FApply<5, Functor> {
  __HDI__ static float apply(
      Functor functor,
      functional::Array<functional::Tensor<float>, 5>& in,
      const functional::Array<int, 5>& indices) {
    return functor(in[0][indices[0]],
                   in[1][indices[1]],
                   in[2][indices[2]],
                   in[3][indices[3]],
                   in[4][indices[4]]);
  }

  __HDI__ static float apply(
      Functor functor,
      functional::Array<functional::Tensor<float>, 5>& in,
      int index) {
    return functor(in[0][index], in[1][index], in[2][index], in[3][index], in[4][index]);
  }
};

template <size_t K, class Functor>
__HDI__ float apply(Functor functor,
                    functional::Array<functional::Tensor<float>, K>& in,
                    const functional::Array<int, K>& indices) {
  return FApply<K, Functor>::apply(functor, in, indices);
}

template <size_t K, class Functor>
__HDI__ float apply(Functor functor,
                    functional::Array<functional::Tensor<float>, K>& in,
                    int index) {
  return FApply<K, Functor>::apply(functor, in, index);
}

/******************************************************************************/

// @TODO: Rename this. It is a reduction loop.
template <size_t n, size_t N, size_t K>
struct Loop {
  template <class Functor, class AggFunctor>
  __HDI__ static float result(
      Functor functor, float aggInit, AggFunctor aggFunctor,
      functional::Array<functional::Tensor<float>, K>& in,
      const functional::Array<int, K>& pAcc,
      const functional::Array<int, N>& length,
      const functional::Array<int, N>& dim) {
    float agg = aggInit;
    functional::Array<int, K> acc;
    for(int i = 0; i < length[N - n]; ++i) {
      for(size_t j = 0; j < K; ++j) {
        acc[j] = pAcc[j] + (dim[N - n] + i) * in[j].shape().bstride(N - n);
      }
      agg = aggFunctor(agg, Loop<n - 1, N, K>::result(functor, aggInit, aggFunctor, in, acc, length, dim));
    }
    return agg;
  }
};

template <size_t N, size_t K>
struct Loop<1, N, K> {
  template <class Functor, class AggFunctor>
  __HDI__ static float result(
      Functor functor, float aggInit, AggFunctor aggFunctor,
      functional::Array<functional::Tensor<float>, K>& in,
      const functional::Array<int, K>& pAcc,
      const functional::Array<int, N>& length,
      const functional::Array<int, N>& dim) {
    float agg = aggInit;
    functional::Array<int, K> acc;
    for(int i = 0; i < length[N - 1]; ++i) {
      for(size_t j = 0; j < K; ++j) {
        acc[j] = pAcc[j] + (dim[N - 1] + i) * in[j].shape().bstride(N - 1);
      }
      agg = aggFunctor(agg, apply<K>(functor, in, acc));
    }
    return agg;
  }
};

template <size_t N, size_t K, class Functor, class AggFunctor>
__HDI__ float loops(Functor functor, float aggInit, AggFunctor aggFunctor,
                    functional::Array<functional::Tensor<float>, K>& in,
                    const functional::Array<int, N>& length,
                    const functional::Array<int, N>& dim) {
  functional::Array<int, K> acc = {0};
  return Loop<N, N, K>::result(functor, aggInit, aggFunctor, in, acc, length, dim);
}
}  // namespace functional
}  // namespace marian
