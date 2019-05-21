#include "tensors/gpu/add.h"

#include "tensors/gpu/cuda_helpers.h"

#include "functional/functional.h"
#include "functional/shape.h"
#include "functional/tensor.h"
#include "functional/tmp.h"

namespace marian {

namespace gpu {

template <size_t K, class Functor, class AggFunctor>
__global__ void gAggregateGeneric(Functor functor, float aggInit, AggFunctor aggFunctor,
                            const functional::Shape full,
                            functional::Tensor<float> out,
                            functional::Array<functional::Tensor<float>, K> ins,
                            float scale = 1.0) {
  int outLength = out.shape().elements();
  bool same = outLength == full.elements();
  for(int i = 0; i < K; ++i)
    same = same && outLength == ins[i].shape().elements();

  constexpr size_t N = functional::Shape::size();
  functional::Array<int, N> len;
  for(int i = 0; i < N; ++i)
    len[i] = full[i] / out.shape()[i];

  functional::Array<int, N> dims;
  for(int bid = 0; bid < outLength; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < outLength) {
      if(same) {
        out[index] = aggFunctor(out[index], functional::apply(functor, ins, index) * scale);
      } else {
        out.shape().dims(index, dims);
        out[index] = aggFunctor(out[index], functional::loops(functor, aggInit, aggFunctor, ins, len, dims) * scale);
      }
    }
  }
}

template <size_t K, class Functor, class AggFunctor>
__global__ void gAggregateEqual(Functor functor, AggFunctor aggFunctor,
                          functional::Tensor<float> out,
                          functional::Array<functional::Tensor<float>, K> ins,
                          float scale,
                          bool broadcast) {
  int length = out.shape().elements();
  functional::Array<int, functional::Shape::size()> dims;

  for(int bid = 0; bid < length; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < length) {
      functional::Array<int, K> indices;
      indices.fill(index);

      if(broadcast) {
        out.shape().dims(index, dims);
        for(size_t i = 0; i < K; ++i)
          indices[i] = ins[i].shape().bindex(dims);
      }

      out[index] = aggFunctor(out[index], functional::apply(functor, ins, indices) * scale);
    }
  }
}

template <size_t K, class Functor, class AggFunctor>
__global__ void gAggregateReduce(Functor functor, float aggInit, AggFunctor aggFunctor,
                           const functional::Shape full,
                           functional::Tensor<float> out,
                           functional::Array<functional::Tensor<float>, K> ins,
                           float scale = 1.0) {
  int rows = full.elements() / full.back();
  int cols = full.back();

  bool same = true;
  for(int i = 0; i < K; ++i)
    same = same && ins[i].shape().elements() == full.elements();

  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      extern __shared__ float _share[];
      float* _sum = _share;

      if(same) {
        _sum[threadIdx.x] = aggInit;
        for(int tid = 0; tid < cols; tid += blockDim.x) {
          int id = tid + threadIdx.x;
          if(id < cols)
            _sum[threadIdx.x] = aggFunctor(_sum[threadIdx.x], functional::apply(functor, ins, j * cols + id));
        }
      } else {
        functional::Array<int, functional::Shape::size()> dims;
        _sum[threadIdx.x] = aggInit;

        for(int tid = 0; tid < cols; tid += blockDim.x) {
          int id = tid + threadIdx.x;
          if(id < cols) {
            full.dims(j * cols + id, dims);
            functional::Array<int, K> indices;
            for(int i = 0; i < K; ++i)
              indices[i] = ins[i].shape().bindex(dims);
            _sum[threadIdx.x] = aggFunctor(_sum[threadIdx.x], functional::apply(functor, ins, indices));
          }
        }
      }
      __syncthreads();
      int len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1)) {
          _sum[threadIdx.x] = aggFunctor(_sum[threadIdx.x], _sum[threadIdx.x + skip]);
        }
        len = (len + 1) >> 1;
      }
      __syncthreads();
      out[j] = aggFunctor(out[j], _sum[0] * scale);
    }
    __syncthreads();
  }
}

template <class Functor, class AggFunctor, class... Tensors>
void Aggregate(Functor functor, float aggInit, AggFunctor aggFunctor, float scale, marian::Tensor out, Tensors... tensors) {
  cudaSetDevice(out->getDeviceId().no);

  auto full = marian::Shape::broadcast({out, tensors...});

  int length = out->shape().elements();

  constexpr size_t K = sizeof...(Tensors);

  functional::Tensor<float> gOut = out;
  functional::Array<functional::Tensor<float>, K> gIns = {tensors...};

  if(full.back() != 1 && out->shape().back() == 1) {
    size_t m = full.elements() / length;
    size_t k = full.back();

    int blocks = std::min(MAX_BLOCKS, (int)m);
    int threads = std::min(MAX_THREADS, (int)k);
    int shared = sizeof(float) * threads;

    gAggregateReduce<<<blocks, threads, shared>>>(functor, aggInit, aggFunctor, full, gOut, gIns, scale);

  } else if(out->shape() == full) {
    int threads = std::min(MAX_THREADS, length);
    int blocks
        = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

    bool broadcast = false;
    for(int i = 0; i < K; ++i)
      broadcast = broadcast || gOut.shape() != gIns[i].shape();
    gAggregateEqual<<<blocks, threads>>>(functor, aggFunctor, gOut, gIns, scale, broadcast);
  } else {
    int threads = std::min(MAX_THREADS, length);
    int blocks
        = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

    gAggregateGeneric<<<blocks, threads>>>(functor, aggInit, aggFunctor, full, gOut, gIns, scale);
  }
}

// @TODO: this is a duplicate; can be removed, but need to redo all the add.inc entries...
template <class Functor, class... Tensors>
void Add(Functor functor, float scale, marian::Tensor out, Tensors... tensors) {
  cudaSetDevice(out->getDeviceId().no);

  auto full = marian::Shape::broadcast({out, tensors...});

  int length = out->shape().elements();

  constexpr size_t K = sizeof...(Tensors);

  functional::Tensor<float> gOut = out;
  functional::Array<functional::Tensor<float>, K> gIns = {tensors...};

  auto addFunctor = functional::_1 + functional::_2;

  if(full.back() != 1 && out->shape().back() == 1) {
    size_t m = full.elements() / length;
    size_t k = full.back();

    int blocks = std::min(MAX_BLOCKS, (int)m);
    int threads = std::min(MAX_THREADS, (int)k);
    int shared = sizeof(float) * threads;

    gAggregateReduce<<<blocks, threads, shared>>>(functor, 0, addFunctor, full, gOut, gIns, scale);

  } else if(out->shape() == full) {
    int threads = std::min(MAX_THREADS, length);
    int blocks
        = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

    bool broadcast = false;
    for(int i = 0; i < K; ++i)
      broadcast = broadcast || gOut.shape() != gIns[i].shape();
    gAggregateEqual<<<blocks, threads>>>(functor, addFunctor, gOut, gIns, scale, broadcast);
  } else {
    int threads = std::min(MAX_THREADS, length);
    int blocks
        = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

    gAggregateGeneric<<<blocks, threads>>>(functor, 0, addFunctor, full, gOut, gIns, scale);
  }
}

#include "tensors/gpu/add.inc"
}  // namespace gpu
}  // namespace marian
