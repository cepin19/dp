//#include <thrust/transform_reduce.h>

#include "tensors/tensor_operators.h"

#include "functional/functional.h"
#include "functional/tensor.h"
#include "tensors/gpu/backend.h"
#include "tensors/gpu/cuda_helpers.h"

#include "3rd_party/reduce_all.h"

namespace marian {

namespace gpu {

struct isnan_test {
  __host__ __device__ bool operator()(const float a) const { return isnan(a); }
};

__device__ inline float stableSigmoid(float x) {
  if(x >= 0) {
    float z = expf(-x);
    return 1.0 / (1.0 + z);
  } else {
    float z = expf(x);
    return z / (1.0 + z);
  }
}

template <typename T>
__global__ void gIsNan(T* in, int length, bool* isNan, bool* isInf, bool zero) {
  for(int bid = 0; bid < length; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < length) {
      if(isnan((float)in[index])) {
        if(zero) in[index] = (T)0.f;
        *isNan = true;
      }
      else if(isinf((float)in[index])) {
        if(zero) in[index] = (T)0.f;
        *isInf = true;
      }
    }
  }
}

void IsNan(Tensor in, Ptr<Allocator> allocator, bool& isNan, bool& isInf, bool zero) {
  cudaSetDevice(in->getDeviceId().no);

  int length = in->size();

  int threads = std::min(MAX_THREADS, length);
  int blocks = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

  auto mem = allocator->alloc<bool>(2);
  bool* dIsNan = &mem->data<bool>()[0];
  bool* dIsInf = &mem->data<bool>()[1];
  fill(in->getBackend(), dIsNan, dIsNan + 2, false);

  if(in->type() == Type::float32) {
    gIsNan<<<blocks, threads>>>(in->data<float>(), length, dIsNan, dIsInf, zero);
  } else {
    ABORT("IsNan for type {} not implemented", in->type());
  }

  CudaCopy(dIsNan, dIsNan + 1, &isNan);
  CudaCopy(dIsInf, dIsInf + 1, &isInf);

  allocator->free(mem);

  cudaStreamSynchronize(0);
}

void ConcatCont(Tensor out, const std::vector<Tensor>& inputs, int axis) {
  cudaSetDevice(out->getDeviceId().no);
  int step = 1;
  for(int i = 0; i < axis; ++i)
    step *= out->shape()[i];

  size_t offset1 = 0;
  for(int i = 0; i < step; ++i) {
    for(auto in : inputs) {
      size_t size = in->shape().elements() / step;
      size_t offset2 = i * size;

      cudaMemcpy(out->data() + offset1,
                 in->data() + offset2,
                 size * sizeof(float),
                 cudaMemcpyDeviceToDevice);

      offset1 += size;
    }
  }
  cudaStreamSynchronize(0);
}

template <bool add>
__global__ void gInsertCols(float* out,
                            const float* in,
                            size_t rows,
                            size_t cols,
                            size_t cols_out,
                            size_t cols_in,
                            size_t offset_out,
                            size_t offset_in) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float* rowOut = out + j * cols_out + offset_out;
      const float* rowIn = in + j * cols_in + offset_in;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols)
          if(add)
            rowOut[i] += rowIn[i];
          else
            rowOut[i] = rowIn[i];
      }
    }
  }
}

void Concatenate1(Tensor out, const std::vector<Tensor>& inputs) {
  cudaSetDevice(out->getDeviceId().no);

  int rows = out->shape().elements() / out->shape().back();

  size_t offset = 0;
  int cols_out = out->shape().back();

  for(auto in : inputs) {
    ABORT_IF(rows != in->shape().elements() / in->shape().back(),
             "First dimension must be equal");
    int cols_in = in->shape().back();

    int blocks = std::min(MAX_BLOCKS, rows);
    int threads = std::min(MAX_THREADS, cols_in);

    gInsertCols<false><<<blocks, threads>>>(
        out->data(), in->data(), rows, cols_in, cols_out, cols_in, offset, 0);
    offset += cols_in;
  }
  cudaStreamSynchronize(0);
}

__global__ void gJoin2(float* out,
                       size_t rowBatch,
                       size_t cols,
                       const float* in1,
                       size_t inStride1,
                       const float* in2,
                       size_t inStride2) {
  int outStride = inStride1 + inStride2;
  int rows = rowBatch * outStride;

  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float* rowOut = out + j * cols;

      int curBatch = j / outStride;
      int curPos = j % outStride;

      int jIn1 = (curBatch * inStride1) + curPos;
      int jIn2 = (curBatch * inStride2) + curPos - inStride1;

      const float* rowIn1 = in1 + jIn1 * cols;
      const float* rowIn2 = in2 + jIn2 * cols;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols) {
          if(curPos < inStride1)
            rowOut[i] = rowIn1[i];
          else
            rowOut[i] = rowIn2[i];
        }
      }
    }
  }
}

void Concatenate2(Tensor out, Tensor in1, Tensor in2) {
  cudaSetDevice(out->getDeviceId().no);

  size_t rows = out->shape().elements() / out->shape().back();
  size_t cols = out->shape().back();

  size_t rowStride1 = in1->shape()[-2];
  size_t rowStride2 = in2->shape()[-2];

  size_t rowBatch = rows / out->shape()[-2];

  int blocks = std::min(MAX_BLOCKS, (int)rows);
  int threads = std::min(MAX_THREADS, (int)cols);

  gJoin2<<<blocks, threads>>>(out->data(),
                              rowBatch,
                              cols,
                              in1->data(),
                              rowStride1,
                              in2->data(),
                              rowStride2);

  cudaStreamSynchronize(0);
}

void Concatenate(Tensor out, const std::vector<Tensor>& inputs, int ax) {
  if(ax == out->shape().size() - 1)
    Concatenate1(out, inputs);
  else if(ax == out->shape().size() - 2 && inputs.size() == 2)
    Concatenate2(out, inputs[0], inputs[1]);
  else
    ConcatCont(out, inputs, ax);
}

void Split1(std::vector<Tensor>& outputs, const Tensor in) {
  cudaSetDevice(in->getDeviceId().no);

  size_t offset = 0;
  int rows = in->shape().elements() / in->shape().back();
  int cols_in = in->shape().back();
  for(auto out : outputs) {
    ABORT_IF(rows != out->shape().elements() / out->shape().back(),
             "First dimension must be equal");
    int cols_out = out->shape().back();

    int blocks = std::min(MAX_BLOCKS, rows);
    int threads = std::min(MAX_THREADS, cols_out);

    gInsertCols<true><<<blocks, threads>>>(
        out->data(), in->data(), rows, cols_out, cols_out, cols_in, 0, offset);
    offset += cols_out;
  }
  cudaStreamSynchronize(0);
}

// @TODO: this function is just a temporary fix until I come up with
// something better for the situation below.
__global__ void gAddRow(float* out, const float* in, int length) {
  for(int bid = 0; bid < length; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < length) {
      out[index] = in[index] + out[index];
    }
  }
}

void SplitCont(std::vector<Tensor>& outputs, const Tensor in, int axis) {
  cudaSetDevice(in->getDeviceId().no);

  int step = 1;
  for(int i = 0; i < axis; ++i)
    step *= in->shape()[i];

  int offset1 = 0;
  for(int i = 0; i < step; ++i) {
    for(auto out : outputs) {
      int size = out->shape().elements() / step;
      int offset2 = i * size;

      // BUG: this is does not add gradients
      // cudaMemcpyAsync(out->data() + offset2,
      //                in->data() + offset1,
      //                size * sizeof(float),
      //                cudaMemcpyDeviceToDevice);

      // @TODO: this is a quick but bad fix for the above bug
      int threads = std::min(MAX_THREADS, size);
      int blocks = std::min(MAX_BLOCKS, size / threads + (size % threads != 0));

      gAddRow<<<blocks, threads>>>(
          out->data() + offset2, in->data() + offset1, size);
      offset1 += size;
    }
  }
  cudaStreamSynchronize(0);
}

void Deconcatenate(std::vector<Tensor>& outputs, const Tensor in, int ax) {
  if(ax == in->shape().size() - 1)
    Split1(outputs, in);
  else
    SplitCont(outputs, in, ax);
}

template <bool add>
__global__ void gTransposeND(
    functional::Tensor<float> out,
    const functional::Tensor<float> in,
    const functional::Array<int, functional::Shape::size()> permute) {
  constexpr size_t N = functional::Shape::size();
  functional::Array<int, N> oDims;
  functional::Array<int, N> pDims;

  int length = out.shape().elements();
  for(int bid = 0; bid < length; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < length) {
      out.shape().dims(index, oDims);
      for(int i = 0; i < N; ++i)
        pDims[permute[i]] = oDims[i];
      if(add)
        out[index] += in[pDims];
      else
        out[index] = in[pDims];
    }
  }
}

template <bool add>
__global__ void gTranspose0213(float* out,
                               const float* in,
                               int rows,
                               int cols,
                               int stride1,
                               int stride2) {
  int stride = stride1 * stride2;
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float* rowOut = out + j * cols;

      int z = j / stride;
      int y = (j % stride) / stride1;
      int x = (j % stride) % stride1;
      int j2 = z * stride + x * stride2 + y;

      const float* rowIn = in + j2 * cols;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols) {
          if(add)
            rowOut[i] += rowIn[i];
          else
            rowOut[i] = rowIn[i];
        }
      }
    }
  }
}

void TransposeND(Tensor out, Tensor in, const std::vector<int>& vAxis) {
  cudaSetDevice(out->getDeviceId().no);
  if(vAxis == std::vector<int>({0, 2, 1, 3})) {
    int rows = out->shape().elements() / out->shape().back();
    int cols = out->shape().back();

    int blocks = std::min(MAX_BLOCKS, rows);
    int threads = std::min(MAX_THREADS, cols);

    int stride1 = out->shape()[-2];
    int stride2 = out->shape()[-3];

    gTranspose0213<false><<<blocks, threads>>>(
        out->data(), in->data(), rows, cols, stride1, stride2);
  } else {
    functional::Array<int, functional::Shape::size()> axes;
    int diff = functional::Shape::size() - vAxis.size();
    for(int i = 0; i < axes.size(); ++i)
      if(i < diff)
        axes[i] = i;
      else
        axes[i] = vAxis[i - diff] + diff;

    int length = out->shape().elements();
    int threads = std::min(MAX_THREADS, length);
    int blocks
        = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

    gTransposeND<false><<<blocks, threads>>>(out, in, axes);
  }
}

void TransposeNDGrad(Tensor out, Tensor in, const std::vector<int>& vAxis) {
  cudaSetDevice(out->getDeviceId().no);
  if(vAxis == std::vector<int>({0, 2, 1, 3})) {
    int rows = out->shape().elements() / out->shape().back();
    int cols = out->shape().back();

    int blocks = std::min(MAX_BLOCKS, rows);
    int threads = std::min(MAX_THREADS, cols);

    int stride1 = out->shape()[-2];
    int stride2 = out->shape()[-3];

    gTranspose0213<true><<<blocks, threads>>>(
        out->data(), in->data(), rows, cols, stride1, stride2);
  } else {
    functional::Array<int, functional::Shape::size()> axes;
    int diff = functional::Shape::size() - vAxis.size();
    for(int i = 0; i < axes.size(); ++i)
      if(i < diff)
        axes[i] = i;
      else
        axes[i] = vAxis[i - diff] + diff;

    int length = out->shape().elements();
    int threads = std::min(MAX_THREADS, length);
    int blocks
        = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

    gTransposeND<true><<<blocks, threads>>>(out, in, axes);
  }
}

// Computes the softmax
// in - input tensor
// out - output tensor
// we compute the softmax over the the cols (last dimension)
// rows are time, batch or beam dimensions
// number of threads is number of cols or MAX_THREADS
// number of blocks is number of rows or MAX_BLOCKS
__global__ void gSoftmax(float* out,
                         functional::Shape outShape,
                         const float* in) {
  int rows = outShape.elements() / outShape.back();
  int cols = outShape.back();

  for(int bid = 0; bid < rows; bid += gridDim.x) { // loop over blocks of rows
    int j = bid + blockIdx.x; // blockIdx.x - row index (within block of rows)
    if(j < rows) { // compute softmax over one row, row elements distributed over threads
      float* so = out + j * cols; // pointer to row input data
      const float* sp = in + j * cols;

      extern __shared__ float _share[];

      // determine max (used below to improve numeric stability)
      float* _max = _share;
      _max[threadIdx.x] = -CUDA_FLT_MAX; // [threadIdx.x = relative column index within a block of columns]
      // find max over column indices that have the same relative column index (=threadIdx.x) across all blocks of columns
      for(int tid = 0; tid < cols; tid += blockDim.x) { // loop over blocks of columns, blockDim.x = index of block of columns
        // threadIdx.x = column index within block of columns; we reduce over columns within a block, then over blocks
        int i = tid + threadIdx.x;
        if(i < cols) {
          if(sp[i] > _max[threadIdx.x])
            _max[threadIdx.x] = sp[i];
        }
      }
      __syncthreads();
      // max over columns within a column block via tree reduction
      int len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1)) {
          if(_max[threadIdx.x + skip] > _max[threadIdx.x]) {
            _max[threadIdx.x] = _max[threadIdx.x + skip];
          }
        }
        len = (len + 1) >> 1;
      }
      __syncthreads();
      float max = _max[0];
      __syncthreads(); // @TODO: do we need this?

      // compute denominator
      float* _sum = _share;
      _sum[threadIdx.x] = 0.0;
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols) {
          // @TODO: is it faster to cache the result of expf() in GPU RAM, or would it be faster to recompute it below?
          float ex = __expf(sp[i] - max);
          so[i] = ex;
          _sum[threadIdx.x] += ex;
        }
      }
      __syncthreads();
      // now reduce over all columns within the block
      len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1))
          _sum[threadIdx.x] += _sum[threadIdx.x + skip];
        len = (len + 1) >> 1;
      }
      __syncthreads();

      // produce final output data
      float sum = _sum[0];
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols) {
          so[i] = so[i] / sum;
        }
      }
    }
    __syncthreads();
  }
}

void Softmax(Tensor out, Tensor in) {
  cudaSetDevice(out->getDeviceId().no);

  size_t m = out->shape().elements() / out->shape().back();
  size_t k = out->shape().back();

  int blocks = std::min(MAX_BLOCKS, (int)m);
  int threads = std::min(MAX_THREADS, (int)k);
  int shared = sizeof(float) * threads;

  gSoftmax<<<blocks, threads, shared>>>(out->data(), out->shape(), in->data());
}

// @TODO: refactor to reuse code from softmax, add comments
__global__ void gLogSoftmax(float* out,
                            const functional::Shape outShape,
                            const float* in) {
  int rows = outShape.elements() / outShape.back();
  int cols = outShape.back();

  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float* so = out + j * cols;
      const float* sp = in + j * cols;

      extern __shared__ float _share[];

      float* _max = _share;
      _max[threadIdx.x] = sp[threadIdx.x];
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          if(sp[id] > _max[threadIdx.x])
            _max[threadIdx.x] = sp[id];
        }
      }
      __syncthreads();
      int len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1)) {
          if(_max[threadIdx.x + skip] > _max[threadIdx.x]) {
            _max[threadIdx.x] = _max[threadIdx.x + skip];
          }
        }
        len = (len + 1) >> 1;
      }
      __syncthreads();
      float max = _max[0];
      __syncthreads();

      float* _sum = _share;

      _sum[threadIdx.x] = 0.0;
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          float sm = sp[id] - max;
          float ex = __expf(sm);
          so[id] = sm;
          _sum[threadIdx.x] += ex;
        }
      }
      __syncthreads();
      len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1))
          _sum[threadIdx.x] += _sum[threadIdx.x + skip];
        len = (len + 1) >> 1;
      }
      __syncthreads();
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols)
          so[id] -= __logf(_sum[0]);
      }
    }
    __syncthreads();
  }
}

void LogSoftmax(Tensor out, Tensor in) {
  cudaSetDevice(out->getDeviceId().no);

  size_t m = out->shape().elements() / out->shape().back();
  size_t k = out->shape().back();

  int blocks = std::min(MAX_BLOCKS, (int)m);
  int threads = std::min(MAX_THREADS, (int)k);
  int shared = sizeof(float) * threads;

  gLogSoftmax<<<blocks, threads, shared>>>(
      out->data(), out->shape(), in->data());
}

///////////////////////////////////////////////////////

__global__ void gSoftmaxGrad(float* grad,
                             const float* adj,
                             const float* val,
                             const int rows,
                             const int cols) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      extern __shared__ float _share[];
      float* _sum = _share;

      float* gradRow = grad + j * cols;
      const float* adjRow = adj + j * cols;
      const float* valRow = val + j * cols;
      _sum[threadIdx.x] = 0.0;
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          _sum[threadIdx.x] += valRow[id] * adjRow[id];
        }
      }
      __syncthreads();
      int len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1))
          _sum[threadIdx.x] += _sum[threadIdx.x + skip];
        len = (len + 1) >> 1;
      }
      __syncthreads();
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          float val = valRow[id] * (adjRow[id] - _sum[0]);
          if(val)
            gradRow[id] += val;
        }
      }
    }
    __syncthreads();
  }
}

// @TODO: refactor with logsoftmax, add math
void SoftmaxGrad(Tensor grad, Tensor adj, Tensor val) {
  cudaSetDevice(adj->getDeviceId().no);
  // grad and val are both m-by-k matrices, passed as input.
  // A weighted average of each row of grad (according to the weights
  // specified in val) is computed and subtracted from Out.
  // adj is multiplied for each element to get backward step in autodiff
  int m = grad->shape().elements() / grad->shape().back();
  int k = grad->shape().back();

  int blocks = std::min(MAX_BLOCKS, m);
  int threads = std::min(MAX_THREADS, k);
  int shared = sizeof(float) * threads;
  gSoftmaxGrad<<<blocks, threads, shared>>>(
      grad->data(), adj->data(), val->data(), m, k);
}

__global__ void gLogSoftmaxGrad(float* grad,
                                const float* adj,
                                const float* val,
                                const int rows,
                                const int cols) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      extern __shared__ float _share[];
      float* _sum = _share;

      float* gradRow = grad + j * cols;
      const float* adjRow = adj + j * cols;
      const float* valRow = val + j * cols;
      _sum[threadIdx.x] = 0.0;
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          _sum[threadIdx.x] += adjRow[id];
        }
      }
      __syncthreads();
      int len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1))
          _sum[threadIdx.x] += _sum[threadIdx.x + skip];
        len = (len + 1) >> 1;
      }
      __syncthreads();
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols)
          gradRow[id] += adjRow[id] - (expf(valRow[id]) * _sum[0]);
      }
    }
    __syncthreads();
  }
}

void LogSoftmaxGrad(Tensor grad, Tensor adj, Tensor val) {
  cudaSetDevice(adj->getDeviceId().no);

  // grad and val are both m-by-k matrices, passed as input.
  // A weighted average of each row of grad (according to the weights
  // specified in val) is computed and subtracted from Out.
  // adj is multiplied for each element to get backward step in autodiff
  int m = grad->shape().elements() / grad->shape().back();
  int k = grad->shape().back();

  int blocks = std::min(MAX_BLOCKS, m);
  int threads = std::min(MAX_THREADS, k);
  int shared = sizeof(float) * threads;
  gLogSoftmaxGrad<<<blocks, threads, shared>>>(
      grad->data(), adj->data(), val->data(), m, k);
}

///////////////////////////////////////////////////////
__global__ void gArgmax(float* out,
                        const float* data,
                        size_t rows,
                        size_t cols) {
  size_t row = blockIdx.x;
  size_t startInd = row * cols;
  float maxScore = -99999;
  size_t maxInd;
  for(size_t col = 0; col < cols; ++col) {
    size_t ind = startInd + col;
    float score = data[ind];
    if(score > maxScore) {
      maxScore = score;
      maxInd = col;
    }
  }
  out[row] = maxInd;
}

///////////////////////////////////////////////////////

__global__ void gCopyRows(float* out,
                          const float* in,
                          size_t cols,
                          const IndexType* sourceRowIdx,
                          size_t rows) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      size_t dstId = j;
      size_t srcId = sourceRowIdx[j];

      float* rowOut = out + dstId * cols;
      const float* rowIn = in + srcId * cols;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols)
          rowOut[i] = rowIn[i];
      }
    }
  }
}

void CopyRows(Tensor out,
              const Tensor in,
              const Tensor indices) {

  matchOrAbort<IndexType>(indices->type());

  cudaSetDevice(out->getDeviceId().no);

  size_t cols = in->shape().back();
  size_t rowsToCopy = indices->size();

  int threads = std::min(MAX_THREADS, (int)cols);
  int blocks = std::min(MAX_BLOCKS, (int)rowsToCopy);

  gCopyRows<<<blocks, threads>>>(
      out->data(), in->data(), cols, indices->data<IndexType>(), rowsToCopy);
}

__global__ void gPasteRows(float* out,
                           const float* in,
                           size_t cols,
                           const IndexType* targetRowIdx,
                           size_t rows) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      size_t dstId = targetRowIdx[j];
      size_t srcId = j;

      float* rowOut = out + dstId * cols;
      const float* rowIn = in + srcId * cols;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols)
          atomicAdd(rowOut + i, rowIn[i]);
      }
    }
  }
}

void PasteRows(Tensor out,
               const Tensor in,
               const Tensor indices) {

  matchOrAbort<IndexType>(indices->type());

  cudaSetDevice(out->getDeviceId().no);

  size_t cols = in->shape().back();
  size_t rowsToCopy = indices->size();

  int threads = std::min(MAX_THREADS, (int)cols);
  int blocks = std::min(MAX_BLOCKS, (int)rowsToCopy);

  gPasteRows<<<blocks, threads>>>(
      out->data(), in->data(), cols, indices->data<IndexType>(), rowsToCopy);
}

/////////////

__global__ void gCopyCols(float* out,
                          const float* in,
                          size_t rows,
                          size_t colsIn,
                          const IndexType* sourceColIdx,
                          size_t colsOut) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      const float* rowIn = in + j * colsIn;
      float* rowOut = out + j * colsOut;

      for(int tid = 0; tid < colsOut; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < colsOut)
          rowOut[i] = rowIn[sourceColIdx[i]];
      }
    }
  }
}

void CopyCols(Tensor out, const Tensor in, const Tensor indices) {
  matchOrAbort<IndexType>(indices->type());

  cudaSetDevice(out->getDeviceId().no);

  size_t rows = in->shape().elements() / in->shape().back();
  size_t cols = in->shape().back();

  size_t colsToCopy = indices->size();

  int threads = std::min(MAX_THREADS, (int)colsToCopy);
  int blocks = std::min(MAX_BLOCKS, (int)rows);

  gCopyCols<<<blocks, threads>>>(
      out->data(), in->data(), rows, cols, indices->data<IndexType>(), colsToCopy);
}

__global__ void gPasteCols(float* out,
                           const float* in,
                           size_t rows,
                           size_t colsOut,
                           const IndexType* targetColIdx,
                           size_t colsIn) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      const float* rowIn = in + j * colsIn;
      float* rowOut = out + j * colsOut;

      for(int tid = 0; tid < colsIn; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < colsIn)
          rowOut[targetColIdx[i]] += rowIn[i];
      }
    }
  }
}

void PasteCols(Tensor out,
               const Tensor in,
               const Tensor indices) {
  matchOrAbort<IndexType>(indices->type());

  cudaSetDevice(out->getDeviceId().no);

  size_t rows = in->shape().elements() / in->shape().back();
  size_t cols = in->shape().back();

  size_t colsToCopy = indices->size();

  int threads = std::min(MAX_THREADS, (int)colsToCopy);
  int blocks = std::min(MAX_BLOCKS, (int)rows);

  gPasteCols<<<blocks, threads>>>(
      out->data(), in->data(), rows, cols, indices->data<IndexType>(), colsToCopy);
}

__global__ void gSelect(float* out,
                        functional::Shape outShape,
                        const float* in,
                        const functional::Shape inShape,
                        int axis,
                        IndexType* d_indices) {
  int length = outShape.elements();
  functional::Array<int, functional::Shape::size()> dims;

  for(int bid = 0; bid < length; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < length) {
      outShape.dims(index, dims);
      dims[axis] = d_indices[dims[axis]];
      int inIndex = inShape.index(dims);
      out[index] = in[inIndex];
    }
  }
}

__global__ void gInsert(float* out,
                        functional::Shape outShape,
                        const float* in,
                        const functional::Shape inShape,
                        int axis,
                        IndexType* d_indices) {
  int length = inShape.elements();
  functional::Array<int, functional::Shape::size()> dims;

  for(int bid = 0; bid < length; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < length) {
      inShape.dims(index, dims);
      dims[axis] = d_indices[dims[axis]];
      int outIndex = outShape.index(dims);
      out[outIndex] += in[index];
    }
  }
}

void Select(Tensor out,
            const Tensor in,
            const Tensor indices,
            int axis) {
  matchOrAbort<IndexType>(indices->type());

  cudaSetDevice(out->getDeviceId().no);

  int length = out->shape().elements();

  int threads = std::min(MAX_THREADS, length);
  int blocks = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

  int axisGPU = axis + functional::Shape::size() - out->shape().size();
  gSelect<<<blocks, threads>>>(out->data(),
                               out->shape(),
                               in->data(),
                               in->shape(),
                               axisGPU,
                               indices->data<IndexType>());
}

void Insert(Tensor out,
            const Tensor in,
            const Tensor indices,
            int axis) {
  matchOrAbort<IndexType>(indices->type());
  cudaSetDevice(in->getDeviceId().no);

  int length = in->shape().elements();

  int threads = std::min(MAX_THREADS, length);
  int blocks = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

  int axisGPU = axis + functional::Shape::size() - out->shape().size();
  gInsert<<<blocks, threads>>>(out->data(),
                               out->shape(),
                               in->data(),
                               in->shape(),
                               axisGPU,
                               indices->data<IndexType>());
}

__global__ void gGRUFastForward(float* out,
                                const float* state,
                                const float* xW,
                                const float* sU,
                                const float* b,
                                const float* mask,
                                size_t rows,
                                size_t cols,
                                bool final) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float m = !mask || mask[j];
      float* rowOut = out + j * cols;
      const float* rowState = state + j * cols;

      const float* xWrow = xW + j * cols * 3;
      const float* sUrow = sU + j * cols * 3;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols) {
          float r = stableSigmoid(xWrow[i] + sUrow[i] + b[i]);

          int k = i + cols;

          float z = stableSigmoid(xWrow[k] + sUrow[k] + b[k]);

          int l = i + 2 * cols;
          float h;
          if(final)
            h = tanhf(xWrow[l] + (sUrow[l] + b[l]) * r);
          else
            h = tanhf(xWrow[l] + sUrow[l] * r + b[l]);

          float out = (1.0f - z) * h + z * rowState[i];
          rowOut[i] = m * out + (1 - m) * rowState[i];
        }
      }
    }
  }
}

void GRUFastForward(Tensor out, std::vector<Tensor> inputs, bool final) {
  cudaSetDevice(out->getDeviceId().no);

  int rows = out->shape().elements() / out->shape().back();
  int cols = out->shape().back();

  int blocks = std::min(MAX_BLOCKS, rows);
  int threads = std::min(MAX_THREADS, cols);

  gGRUFastForward<<<blocks, threads>>>(
      out->data(),                                // output
      inputs[0]->data(),                          // state
      inputs[1]->data(),                          // xW
      inputs[2]->data(),                          // sU
      inputs[3]->data(),                          // b
      inputs.size() > 4 ? inputs[4]->data() : 0,  // mask
      rows,
      cols,
      final);
}

__global__ void gGRUFastBackward(float* outState,
                                 float* outXW,
                                 float* outSU,
                                 float* outB,
                                 const float* state,
                                 const float* xW,
                                 const float* sU,
                                 const float* b,
                                 const float* mask,
                                 const float* adj,
                                 size_t rows,
                                 size_t cols,
                                 bool final) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float m = !mask || mask[j];

      float* rowOutState = outState + j * cols;
      float* rowOutXW = outXW + j * cols * 3;
      float* rowOutSU = outSU + j * cols * 3;

      const float* rowState = state + j * cols;
      const float* rowXW = xW + j * cols * 3;
      const float* rowSU = sU + j * cols * 3;
      const float* rowAdj = adj + j * cols;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols) {
          int k = i + cols;
          int l = i + 2 * cols;

          float r = stableSigmoid(rowXW[i] + rowSU[i] + b[i]);
          float z = stableSigmoid(rowXW[k] + rowSU[k] + b[k]);

          float h;
          if(final)
            h = tanhf(rowXW[l] + (rowSU[l] + b[l]) * r);
          else
            h = tanhf(rowXW[l] + rowSU[l] * r + b[l]);

          float adj = rowAdj[i];

          float t = (1 - z) * (1 - h * h);

          // df/ds
          if(outState)
            rowOutState[i] += (m * z - m + 1) * adj;

          // df/d(xW_r) ...
          float dfdxW_r = m * r * (1 - r) * t * adj;
          if(final)
            dfdxW_r *= rowSU[l] + b[l];
          else
            dfdxW_r *= rowSU[l];
          if(outXW)
            rowOutXW[i] += dfdxW_r;
          if(outSU)
            rowOutSU[i] += dfdxW_r;
          if(outB)
            atomicAdd(outB + i, dfdxW_r);

          // df/d(xW_z) ...
          float dfdxW_z = m * (1 - z) * z * (rowState[i] - h) * adj;
          if(outXW)
            rowOutXW[k] += dfdxW_z;
          if(outSU)
            rowOutSU[k] += dfdxW_z;
          if(outB)
            atomicAdd(outB + k, dfdxW_z);

          // df/d(xW_x) ...
          float dfdxW_x = m * t * adj;
          if(outXW)
            rowOutXW[l] += dfdxW_x;
          if(outSU)
            rowOutSU[l] += dfdxW_x * r;
          if(outB)
            if(final)
              atomicAdd(outB + l, dfdxW_x * r);
            else
              atomicAdd(outB + l, dfdxW_x);
        }
      }
    }
  }
}

void GRUFastBackward(std::vector<Tensor> outputs,
                     std::vector<Tensor> inputs,
                     Tensor adj,
                     bool final) {
  cudaSetDevice(adj->getDeviceId().no);

  int rows = adj->shape().elements() / adj->shape().back();
  int cols = adj->shape().back();

  int blocks = std::min(MAX_BLOCKS, rows);
  int threads = std::min(MAX_THREADS, cols);

  gGRUFastBackward<<<blocks, threads>>>(
      outputs[0] ? outputs[0]->data() : 0,        // state - adj
      outputs[1] ? outputs[1]->data() : 0,        // xW - adj
      outputs[2] ? outputs[2]->data() : 0,        // sU - adj
      outputs[3] ? outputs[3]->data() : 0,        // b - adj
      inputs[0]->data(),                          // state
      inputs[1]->data(),                          // xW
      inputs[2]->data(),                          // sU
      inputs[3]->data(),                          // b
      inputs.size() > 4 ? inputs[4]->data() : 0,  // mask
      adj->data(),
      rows,
      cols,
      final);
}

__global__ void gCrossEntropyPick(float* out,
                                  const functional::Shape outShape,
                                  const float* in,
                                  const functional::Shape inShape,
                                  const IndexType* pick) {
  int rows = inShape.elements() / inShape.back();
  int cols = inShape.back();

  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      const float* sp = in + j * cols;

      extern __shared__ float _share[];
      float* _max = _share;

      _max[threadIdx.x] = sp[threadIdx.x];
      for(int tid = 1; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          if(sp[id] > _max[threadIdx.x])
            _max[threadIdx.x] = sp[id];
        }
      }
      __syncthreads();
      int len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1)) {
          if(_max[threadIdx.x + skip] > _max[threadIdx.x]) {
            _max[threadIdx.x] = _max[threadIdx.x + skip];
          }
        }
        len = (len + 1) >> 1;
      }
      __syncthreads();
      float max = _max[0];
      __syncthreads();

      float* _sum = _share;
      _sum[threadIdx.x] = 0.0;
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          _sum[threadIdx.x] += __expf(sp[id] - max);
        }
      }
      __syncthreads();
      len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1))
          _sum[threadIdx.x] += _sum[threadIdx.x + skip];
        len = (len + 1) >> 1;
      }
      __syncthreads();

      // cross-entropy
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id == (int)pick[j]) {
          out[j] = __logf(_sum[0]) - sp[id] + max;
        }
      }
    }
    __syncthreads();
  }
}

// In each j-th row, take the corresponding j-th label index i from indices and compute:
// For each vocabulary item v, the only non-zero element in a row in the sum is the item
// that matches the label indexed by i (the picked element).
// C = sum_{v in V}(-logsoftmax(A) * delta(v, i) = -logsoftmax(A)[i]
void CrossEntropyPick(Tensor out, Tensor in, Tensor indices) {
  matchOrAbort<IndexType>(indices->type());

  cudaSetDevice(out->getDeviceId().no);

  int rows = in->shape().elements() / in->shape().back();
  int cols = in->shape().back();

  int blocks = std::min(MAX_BLOCKS, (int)rows);
  int threads = std::min(MAX_THREADS, (int)cols);
  int shared = sizeof(float) * threads;

  gCrossEntropyPick<<<blocks, threads, shared>>>(
      out->data(), out->shape(), in->data(), in->shape(), indices->data<IndexType>());
}

__global__ void gCrossEntropyPickBackward(float* out,
                                          const functional::Shape outShape,
                                          const float* adj,
                                          const float* in,
                                          const IndexType* pick) {
  int rows = outShape.elements() / outShape.back();
  int cols = outShape.back();
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      const float* sp = in + j * cols;
      float* so = out + j * cols;

      extern __shared__ float _share[];
      float* _max = _share;

      _max[threadIdx.x] = sp[threadIdx.x];
      for(int tid = 1; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          if(sp[id] > _max[threadIdx.x])
            _max[threadIdx.x] = sp[id];
        }
      }
      __syncthreads();
      int len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1)) {
          if(_max[threadIdx.x + skip] > _max[threadIdx.x]) {
            _max[threadIdx.x] = _max[threadIdx.x + skip];
          }
        }
        len = (len + 1) >> 1;
      }
      __syncthreads();
      float max = _max[0];
      __syncthreads();

      float* _sum = _share;
      _sum[threadIdx.x] = 0.0;
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          float ex = __expf(sp[id] - max);
          _sum[threadIdx.x] += ex;
        }
      }
      __syncthreads();
      len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1))
          _sum[threadIdx.x] += _sum[threadIdx.x + skip];
        len = (len + 1) >> 1;
      }
      __syncthreads();

      // cross-entropy
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          float sub = (float)(id == (int)pick[j]);
          so[id] += adj[j] * (__expf(sp[id] - max) / _sum[0] - sub);
        }
      }
    }
    __syncthreads();
  }
}

void CrossEntropyPickBackward(Tensor out, Tensor adj, Tensor a, Tensor indices) {
  matchOrAbort<IndexType>(indices->type());

  cudaSetDevice(out->getDeviceId().no);

  int rows = out->shape().elements() / out->shape().back();
  int cols = out->shape().back();

  int blocks = std::min(MAX_BLOCKS, (int)rows);
  int threads = std::min(MAX_THREADS, (int)cols);
  int shared = sizeof(float) * threads;

  gCrossEntropyPickBackward<<<blocks, threads, shared>>>(
      out->data(), out->shape(), adj->data(), a->data(), indices->data<IndexType>());
}

float L2Norm(Tensor in) {
  cudaSetDevice(in->getDeviceId().no);

  int size = in->shape().elements();
  int threads = std::min(MAX_THREADS, size);
  int blocks = std::min(MAX_BLOCKS, size / threads + (size % threads != 0));

  uint8_t* data;
  cudaMalloc(&data, blocks * sizeof(float));
  Tensor out(new TensorBase(New<MemoryPiece>(data, blocks * sizeof(float)),
                            {1, blocks},
                            in->getBackend()));

  using namespace functional;
  ReduceAll(_1 * _1, out, in);
  float dataCpu = sqrtf(out->get(0));
  out.reset();
  cudaFree(data);
  return dataCpu;
}

__global__ void gAtt(float* out,
                     const float* va,
                     const float* ctx,
                     const float* state,
                     int m,  // total rows (batch x time x beam)
                     int k,  // depth
                     int b,  // batch size
                     int t   // time of ctx
) {
  int rows = m;
  int cols = k;

  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      const float* vaRow = va;
      const float* ctxRow = ctx + (j % (b * t)) * cols;
      const float* stateRow = state + ((j / (b * t)) * b + j % b) * cols;

      extern __shared__ float _share[];
      float* _sum = _share;

      _sum[threadIdx.x] = 0.0;
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          float z = ctxRow[id] + stateRow[id];
          float ex = tanhf(z) * vaRow[id];
          _sum[threadIdx.x] += ex;
        }
      }
      __syncthreads();
      int len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1))
          _sum[threadIdx.x] += _sum[threadIdx.x + skip];
        len = (len + 1) >> 1;
      }
      __syncthreads();
      out[j] = _sum[0];
    }
    __syncthreads();
  }
}

void Att(Tensor out, Tensor va, Tensor context, Tensor state) {
  cudaSetDevice(out->getDeviceId().no);

  size_t m = out->shape().elements() / out->shape().back();
  size_t k = context->shape()[-1];
  size_t b = context->shape()[-2];
  size_t t = context->shape()[-3];

  int blocks = std::min(MAX_BLOCKS, (int)m);
  int threads = std::min(MAX_THREADS, (int)k);
  int shared = sizeof(float) * threads;

  gAtt<<<blocks, threads, shared>>>(
      out->data(), va->data(), context->data(), state->data(), m, k, b, t);
}

__global__ void gAttBack(float* gVa,
                         float* gContext,
                         float* gState,
                         const float* va,
                         const float* context,
                         const float* state,
                         const float* adj,
                         int m,  // rows
                         int k,  // cols
                         int n   // batch size
) {
  int rows = m;
  int cols = k;
  for(int bid = 0; bid < m; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float* gcRow = gContext + j * cols;
      float* gsRow = gState + (j % n) * cols;

      const float* cRow = context + j * cols;
      const float* sRow = state + (j % n) * cols;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          float z = cRow[id] + sRow[id];

          float t = tanhf(z);
          float r = va[id] * (1.f - t * t);

          gcRow[id] += r * adj[j];
          gsRow[id] += r * adj[j];
          atomicAdd(gVa + id, t * adj[j]);
        }
      }
    }
  }
}

void AttBack(Tensor gVa,
             Tensor gContext,
             Tensor gState,
             Tensor va,
             Tensor context,
             Tensor state,
             Tensor adj) {
  cudaSetDevice(adj->getDeviceId().no);

  size_t m = adj->shape().elements() / adj->shape()[-1];
  size_t k = context->shape()[-1];
  size_t n = context->shape()[-2];

  int blocks = std::min(MAX_BLOCKS, (int)n);
  int threads = std::min(MAX_THREADS, (int)k);

  gAttBack<<<blocks, threads>>>(gVa->data(),
                                gContext->data(),
                                gState->data(),

                                va->data(),
                                context->data(),
                                state->data(),

                                adj->data(),
                                m,
                                k,
                                n);
}

__global__ void gLNormalization(float* out,
                                const float* in,
                                const float* alpha,
                                const float* beta,
                                int rows,
                                int cols,
                                float eps = 1e-9) {
  extern __shared__ float _share[];

  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float* so = out + j * cols;
      const float* sp = in + j * cols;

      float* _sum = _share;
      _sum[threadIdx.x] = 0.0f;
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          _sum[threadIdx.x] += sp[id];
        }
      }
      __syncthreads();
      int len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1)) {
          _sum[threadIdx.x] += _sum[threadIdx.x + skip];
        }
        len = (len + 1) >> 1;
      }
      __syncthreads();
      float mean = _sum[0] / cols;
      __syncthreads();

      float* _sqSum = _share;

      _sqSum[threadIdx.x] = 0.0;
      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          float ex = sp[id] - mean;
          _sqSum[threadIdx.x] += ex * ex;
        }
      }
      __syncthreads();
      len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1))
          _sqSum[threadIdx.x] += _sqSum[threadIdx.x + skip];
        len = (len + 1) >> 1;
      }
      __syncthreads();
      float sigma = sqrtf(eps + (_sqSum[0] / cols));
      __syncthreads();

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          float t = alpha[id] * ((sp[id] - mean) / sigma);
          if(beta != nullptr)
            t += beta[id];
          so[id] = t;
        }
      }
    }
    __syncthreads();
  }
}

void LayerNormalization(Tensor out,
                        Tensor in,
                        Tensor gamma,
                        Tensor beta,
                        float eps) {
  cudaSetDevice(out->getDeviceId().no);

  int rows = in->shape().elements() / in->shape().back();
  int cols = in->shape().back();

  int blocks = std::min(MAX_BLOCKS, (int)rows);
  int threads = std::min(MAX_THREADS, (int)cols);
  int shared = threads * sizeof(float);

  gLNormalization<<<blocks, threads, shared>>>(out->data(),
                                               in->data(),
                                               gamma->data(),
                                               beta ? beta->data() : nullptr,
                                               rows,
                                               cols,
                                               eps);
}

__global__ void gLayerNormalizationGrad(float* gradX,
                                        float* gradGamma,
                                        float* gradBeta,
                                        float* adj,
                                        float* y,
                                        float* x,
                                        float* gamma,
                                        float* beta,
                                        int rows,
                                        int cols,
                                        float eps = 1e-9) {
  extern __shared__ float shared[];

  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float* sum_adj = shared;
      float* sum_adj_x = shared + blockDim.x;
      float* sum_x = shared + 2 * blockDim.x;
      float* sum_sqr = shared + 3 * blockDim.x;

      const float* xRow = x + j * cols;
      const float* yRow = y + j * cols;
      const float* adjRow = adj + j * cols;
      float* gradXRow = gradX + j * cols;

      sum_x[threadIdx.x] = 0.0f;
      sum_adj[threadIdx.x] = 0.0f;
      sum_adj_x[threadIdx.x] = 0.0f;
      sum_sqr[threadIdx.x] = 0.0f;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          sum_x[threadIdx.x] += xRow[id];
          sum_adj_x[threadIdx.x]
              += adjRow[id] * (yRow[id] - ((beta) ? beta[id] : 0)) / gamma[id];
          sum_adj[threadIdx.x] += adjRow[id];
        }
      }
      __syncthreads();
      int len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1)) {
          sum_x[threadIdx.x] += sum_x[threadIdx.x + skip];
          sum_adj[threadIdx.x] += sum_adj[threadIdx.x + skip];
          sum_adj_x[threadIdx.x] += sum_adj_x[threadIdx.x + skip];
        }
        len = (len + 1) >> 1;
      }
      __syncthreads();
      float mean = sum_x[0] / cols;
      __syncthreads();

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          float ex = xRow[id] - mean;
          sum_sqr[threadIdx.x] += ex * ex;
        }
      }

      __syncthreads();
      len = blockDim.x;
      while(len != 1) {
        __syncthreads();
        int skip = (len + 1) >> 1;
        if(threadIdx.x < (len >> 1))
          sum_sqr[threadIdx.x] += sum_sqr[threadIdx.x + skip];
        len = (len + 1) >> 1;
      }
      __syncthreads();
      float sigma = sqrtf(eps + (sum_sqr[0] / cols));
      __syncthreads();

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int id = tid + threadIdx.x;
        if(id < cols) {
          float grad_x = 0.0f;
          float x_hat = (yRow[id] - ((beta) ? beta[id] : 0)) / gamma[id];
          grad_x += cols * adjRow[id];
          grad_x -= sum_adj[0];
          grad_x -= sum_adj_x[0] * x_hat;
          grad_x /= (cols * sigma);

          float valX = gamma[id] * grad_x;
          float sign = (0.f < valX) - (valX < 0.f);
          valX = fabs(valX) > 1000 ? sign * 1000 : valX;

          gradXRow[id] += valX;
          atomicAdd(gradGamma + id, adjRow[id] * x_hat);
          if(beta) {
            atomicAdd(gradBeta + id, adjRow[id]);
          }
        }
      }
    }
    __syncthreads();
  }
}

void LayerNormalizationGrad(Tensor gradX,
                            Tensor gradGamma,
                            Tensor gradBeta,
                            Tensor adj,
                            Tensor y,
                            Tensor x,
                            Tensor gamma,
                            Tensor beta,
                            float eps) {
  cudaSetDevice(adj->getDeviceId().no);
  int rows = y->shape().elements() / y->shape()[-1];
  int cols = y->shape()[-1];

  int threads = std::min(MAX_THREADS, cols);
  int blocks = std::min(MAX_BLOCKS, rows);
  int shared = sizeof(float) * threads * 4;

  gLayerNormalizationGrad<<<blocks, threads, shared>>>(
      gradX->data(),
      gradGamma->data(),
      (gradBeta) ? gradBeta->data() : nullptr,
      adj->data(),
      y->data(),
      x->data(),
      gamma->data(),
      (beta) ? beta->data() : nullptr,
      rows,
      cols,
      eps);
}

template <bool add>
__global__ void gShift(float* out,
                       const float* in,
                       int length,
                       int offset,
                       float padValue) {
  for(int bid = 0; bid < length; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < length) {
      if(add) {
        if(index - offset >= 0 && index - offset < length)
          out[index] += in[index - offset];
      } else {
        if(index - offset < 0 || index - offset >= length)
          out[index] = padValue;
        else
          out[index] = in[index - offset];
      }
    }
  }
}

void Shift(Tensor out,
           Tensor in,
           marian::Shape shift,
           float padValue,
           bool invert) {
  ABORT_IF(in->shape().size() != shift.size(), "bad dimensions");

  // BUGBUG: This can only shift along the first axis. Shifting, e.g., along the
  // last axis cannot be implemented this way.
  int offset = 0;
  for(int i = 0; i < shift.size(); ++i)
    offset += in->shape().stride(i) * shift[i];

  if(invert)
    offset = -offset;

  cudaSetDevice(out->getDeviceId().no);

  int length = out->shape().elements();

  int threads = std::min(MAX_THREADS, length);
  int blocks = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

  gShift<false>
      <<<blocks, threads>>>(out->data(), in->data(), length, offset, padValue);
}

void ShiftGrad(Tensor out, Tensor in, marian::Shape shift, bool invert) {
  ABORT_IF(in->shape().size() != shift.size(), "bad dimensions");

  // BUGBUG: This can only shift along the first axis. Shifting, e.g., along the
  // last axis cannot be implemented this way.
  int offset = 0;
  for(int i = 0; i < shift.size(); ++i)
    offset += in->shape().stride(i) * shift[i];

  if(invert)
    offset = -offset;

  cudaSetDevice(out->getDeviceId().no);

  int length = out->shape().elements();

  int threads = std::min(MAX_THREADS, length);
  int blocks = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

  gShift<true>
      <<<blocks, threads>>>(out->data(), in->data(), length, offset, 0.f);
}

__global__ void gSetSparse(float* out,
                           const size_t* indices,
                           const float* values,
                           int length) {
  for(int bid = 0; bid < length; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < length) {
      out[indices[index]] = values[index];
    }
  }
}

void SetSparse(float* out,
               const std::vector<size_t>& indices,
               const std::vector<float>& values) {
  int length = indices.size();

  int threads = std::min(MAX_THREADS, length);
  int blocks = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

  size_t* d_indices;
  CUDA_CHECK(cudaMalloc(&d_indices, length * sizeof(size_t)));
  CUDA_CHECK(cudaMemcpy(d_indices,
                        indices.data(),
                        length * sizeof(size_t),
                        cudaMemcpyHostToDevice));

  float* d_values;
  CUDA_CHECK(cudaMalloc(&d_values, length * sizeof(float)));
  CUDA_CHECK(cudaMemcpy(
      d_values, values.data(), length * sizeof(float), cudaMemcpyHostToDevice));

  gSetSparse<<<blocks, threads>>>(out, d_indices, d_values, length);

  cudaFree(d_indices);
  cudaFree(d_values);
}

/******************************************************************************/

__global__ void gLSTMCellForward(float* out,
                                 const float* cell,
                                 const float* xW,
                                 const float* sU,
                                 const float* b,
                                 const float* mask,
                                 size_t rows,
                                 size_t cols) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float m = !mask || mask[j];

      float* rowOut = out + j * cols;
      const float* rowCell = cell + j * cols;

      const float* xWrow = xW + j * cols * 4;
      const float* sUrow = sU + j * cols * 4;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols) {
          float gf = stableSigmoid(xWrow[i] + sUrow[i] + b[i]);

          int k = i + cols;
          float gi = stableSigmoid(xWrow[k] + sUrow[k] + b[k]);

          int l = i + 2 * cols;
          float gc = tanhf(xWrow[l] + sUrow[l] + b[l]);

          float cout = gf * rowCell[i] + gi * gc;
          rowOut[i] = m * cout + (1 - m) * rowCell[i];
        }
      }
    }
  }
}

void LSTMCellForward(Tensor out, std::vector<Tensor> inputs) {
  cudaSetDevice(out->getDeviceId().no);

  int rows = out->shape().elements() / out->shape().back();
  int cols = out->shape().back();

  int blocks = std::min(MAX_BLOCKS, rows);
  int threads = std::min(MAX_THREADS, cols);

  gLSTMCellForward<<<blocks, threads>>>(
      out->data(),                                // output
      inputs[0]->data(),                          // cell state
      inputs[1]->data(),                          // xW
      inputs[2]->data(),                          // sU
      inputs[3]->data(),                          // b
      inputs.size() > 4 ? inputs[4]->data() : 0,  // mask
      rows,
      cols);
}

__global__ void gLSTMOutputForward(float* out,
                                   const float* cell,
                                   const float* xW,
                                   const float* sU,
                                   const float* b,
                                   size_t rows,
                                   size_t cols) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float* rowOut = out + j * cols;
      const float* rowCell = cell + j * cols;

      const float* xWrow = xW + j * cols * 4;
      const float* sUrow = sU + j * cols * 4;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols) {
          int k = i + 3 * cols;
          float go = stableSigmoid(xWrow[k] + sUrow[k] + b[k]);

          rowOut[i] = go * tanhf(rowCell[i]);
        }
      }
    }
  }
}

void LSTMOutputForward(Tensor out, std::vector<Tensor> inputs) {
  cudaSetDevice(out->getDeviceId().no);

  int rows = out->shape().elements() / out->shape().back();
  int cols = out->shape().back();

  int blocks = std::min(MAX_BLOCKS, rows);
  int threads = std::min(MAX_THREADS, cols);

  gLSTMOutputForward<<<blocks, threads>>>(out->data(),        // output
                                          inputs[0]->data(),  // cell state
                                          inputs[1]->data(),  // xW
                                          inputs[2]->data(),  // sU
                                          inputs[3]->data(),  // b
                                          rows,
                                          cols);
}

__global__ void gLSTMCellBackward(float* outCell,
                                  float* outXW,
                                  float* outSU,
                                  float* outB,
                                  const float* cell,
                                  const float* xW,
                                  const float* sU,
                                  const float* b,
                                  const float* mask,
                                  const float* adj,
                                  size_t rows,
                                  size_t cols) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float m = !mask || mask[j];

      float* rowOutCell = outCell + j * cols;
      float* rowOutXW = outXW + j * cols * 4;
      float* rowOutSU = outSU + j * cols * 4;

      const float* rowCell = cell + j * cols;
      const float* xWrow = xW + j * cols * 4;
      const float* sUrow = sU + j * cols * 4;

      const float* rowAdj = adj + j * cols;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols) {
          float gf = stableSigmoid(xWrow[i] + sUrow[i] + b[i]);

          int k = i + cols;
          float gi = stableSigmoid(xWrow[k] + sUrow[k] + b[k]);

          int l = i + 2 * cols;
          float gc = tanhf(xWrow[l] + sUrow[l] + b[l]);

          float adj = rowAdj[i];

          // dc/dc_{t-1}
          if(outCell)
            rowOutCell[i] += (m * gf - m + 1) * adj;

          // dc/d(b_f) = dc/d(xW_f) ...
          float dcdxf = m * rowCell[i] * gf * (1 - gf) * adj;
          if(outXW)
            rowOutXW[i] += dcdxf;
          if(outSU)
            rowOutSU[i] += dcdxf;
          if(outB)
            atomicAdd(outB + i, dcdxf);

          // dc/d(b_i) ...
          float dcdb_i = m * gc * gi * (1 - gi) * adj;
          if(outXW)
            rowOutXW[k] += dcdb_i;
          if(outSU)
            rowOutSU[k] += dcdb_i;
          if(outB)
            atomicAdd(outB + k, dcdb_i);

          // dc/d(b_c) ...
          float dcdxc = m * gi * (1 - gc * gc) * adj;
          if(outXW)
            rowOutXW[l] += dcdxc;
          if(outSU)
            rowOutSU[l] += dcdxc;
          if(outB)
            atomicAdd(outB + l, dcdxc);
        }
      }
    }
  }
}

void LSTMCellBackward(std::vector<Tensor> outputs,
                      std::vector<Tensor> inputs,
                      Tensor adj) {
  cudaSetDevice(adj->getDeviceId().no);

  int rows = adj->shape().elements() / adj->shape().back();
  int cols = adj->shape().back();

  int blocks = std::min(MAX_BLOCKS, rows);
  int threads = std::min(MAX_THREADS, cols);

  gLSTMCellBackward<<<blocks, threads>>>(
      outputs[0] ? outputs[0]->data() : 0,        // state - adj
      outputs[1] ? outputs[1]->data() : 0,        // xW - adj
      outputs[2] ? outputs[2]->data() : 0,        // sU - adj
      outputs[3] ? outputs[3]->data() : 0,        // b - adj
      inputs[0]->data(),                          // state
      inputs[1]->data(),                          // xW
      inputs[2]->data(),                          // sU
      inputs[3]->data(),                          // b
      inputs.size() > 4 ? inputs[4]->data() : 0,  // mask
      adj->data(),
      rows,
      cols);
}

__global__ void gLSTMOutputBackward(float* outCell,
                                    float* outXW,
                                    float* outSU,
                                    float* outB,
                                    const float* cell,
                                    const float* xW,
                                    const float* sU,
                                    const float* b,
                                    const float* adj,
                                    size_t rows,
                                    size_t cols) {
  for(int bid = 0; bid < rows; bid += gridDim.x) {
    int j = bid + blockIdx.x;
    if(j < rows) {
      float* rowOutCell = outCell + j * cols;
      float* rowOutXW = outXW + j * cols * 4;
      float* rowOutSU = outSU + j * cols * 4;

      const float* rowCell = cell + j * cols;
      const float* xWrow = xW + j * cols * 4;
      const float* sUrow = sU + j * cols * 4;

      const float* rowAdj = adj + j * cols;

      for(int tid = 0; tid < cols; tid += blockDim.x) {
        int i = tid + threadIdx.x;
        if(i < cols) {
          int k = i + 3 * cols;
          float go = stableSigmoid(xWrow[k] + sUrow[k] + b[k]);

          float t = tanhf(rowCell[i]);

          float adj = rowAdj[i];

          // dc/dc_{t-1}
          if(outCell)
            rowOutCell[i] += go * (1 - t * t) * adj;

          // dc/d(b_o) = dc/d(xW_f) ...
          float dcdxo = t * go * (1 - go) * adj;
          if(outXW)
            rowOutXW[k] += dcdxo;
          if(outSU)
            rowOutSU[k] += dcdxo;
          if(outB)
            atomicAdd(outB + k, dcdxo);
        }
      }
    }
  }
}

void LSTMOutputBackward(std::vector<Tensor> outputs,
                        std::vector<Tensor> inputs,
                        Tensor adj) {
  cudaSetDevice(adj->getDeviceId().no);

  int rows = adj->shape().elements() / adj->shape().back();
  int cols = adj->shape().back();

  int blocks = std::min(MAX_BLOCKS, rows);
  int threads = std::min(MAX_THREADS, cols);

  gLSTMOutputBackward<<<blocks, threads>>>(
      outputs[0] ? outputs[0]->data() : 0,  // state - adj
      outputs[1] ? outputs[1]->data() : 0,  // xW - adj
      outputs[2] ? outputs[2]->data() : 0,  // sU - adj
      outputs[3] ? outputs[3]->data() : 0,  // b - adj
      inputs[0]->data(),                    // state
      inputs[1]->data(),                    // xW
      inputs[2]->data(),                    // sU
      inputs[3]->data(),                    // b
      adj->data(),
      rows,
      cols);
}

__global__ void gHighwayForward(float* out,
                                const float* in1,
                                const float* in2,
                                const float* t,
                                size_t length) {
  for(int bid = 0; bid < length; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < length) {
      float sigma = stableSigmoid(t[index]);
      out[index] = in1[index] * sigma + in2[index] * (1.f - sigma);
    }
  }
}

void HighwayForward(Tensor out,
                    const Tensor in1,
                    const Tensor in2,
                    const Tensor t) {
  cudaSetDevice(out->getDeviceId().no);

  int length = out->shape().elements();

  int threads = std::min(MAX_THREADS, length);
  int blocks = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

  gHighwayForward<<<blocks, threads>>>(
      out->data(), in1->data(), in2->data(), t->data(), length);
}

__global__ void gHighwayBackward(float* out1,
                                 float* out2,
                                 float* outt,
                                 const float* in1,
                                 const float* in2,
                                 const float* t,
                                 const float* adj,
                                 size_t length) {
  for(int bid = 0; bid < length; bid += blockDim.x * gridDim.x) {
    int index = bid + blockDim.x * blockIdx.x + threadIdx.x;
    if(index < length) {
      float sigma = stableSigmoid(t[index]);
      out1[index] = sigma * adj[index];
      out2[index] = (1.f - sigma) * adj[index];
      outt[index]
          = sigma * (1.f - sigma) * (in1[index] - in2[index]) * adj[index];
    }
  }
}

void HighwayBackward(Tensor out1,
                     Tensor out2,
                     Tensor outt,
                     const Tensor in1,
                     const Tensor in2,
                     const Tensor t,
                     const Tensor adj) {
  cudaSetDevice(out1->getDeviceId().no);

  int length = out1->shape().elements();

  int threads = std::min(MAX_THREADS, length);
  int blocks = std::min(MAX_BLOCKS, length / threads + (length % threads != 0));

  gHighwayBackward<<<blocks, threads>>>(out1->data(),
                                        out2->data(),
                                        outt->data(),
                                        in1->data(),
                                        in2->data(),
                                        t->data(),
                                        adj->data(),
                                        length);
}

__global__ void gMaxPoolingForward(float* out,
                                   int outRows,
                                   int outCols,
                                   float* in,
                                   int inRows,
                                   int inCols,
                                   float* mask,
                                   int numKernels,
                                   int maskCols,
                                   int width,
                                   int lastWidth) {
  int tid = threadIdx.x + blockIdx.x * blockDim.x;

  if(tid >= outRows * outCols)
    return;

  int rowId = tid / outRows;
  int colId = tid % outRows;

  float* b = in + (rowId * inCols) + (colId * width);
  float* localMask = mask + (rowId / numKernels) * maskCols + colId * width;

  if(colId == outRows - 1) {
    width = lastWidth;
  }

  float currentMax = b[0] * localMask[0];
  for(int i = 1; i < width; ++i) {
    if(b[i] * localMask[i] > currentMax) {
      currentMax = b[i] * localMask[i];
    }
  }

  out[rowId + (colId * outCols)] = currentMax;
}

void PoolingWithMaskingForward(Tensor out,
                               Tensor in,
                               Tensor mask,
                               int width,
                               bool isEven) {
  int n = out->shape().elements();
  int threads = std::min(n, MAX_THREADS);
  int blocks = n / threads + (n % threads != 0);

  auto& inShape = in->shape();
  int inRows = inShape[0] * inShape[1];
  int inCols = inShape[2];

  auto& outShape = out->shape();
  int outRows = outShape[2];
  int outCols = outShape[0] * outShape[1];

  int lastWidth
      = ((inCols - isEven) % width == 0) ? width : (inCols - isEven) % width;

  gMaxPoolingForward<<<blocks, threads>>>(out->data(),
                                          outRows,
                                          outCols,
                                          in->data(),
                                          inRows,
                                          inCols,
                                          mask->data(),
                                          outShape[1],
                                          mask->shape()[2],
                                          width,
                                          lastWidth);
}

__global__ void gMaxPoolingBackward(float* adj,
                                    int adjRows,
                                    int adjCols,
                                    float* in,
                                    float* adjIn,
                                    int inRows,
                                    int inCols,
                                    float* mask,
                                    int numKernels,
                                    int maskCols,
                                    int width,
                                    int lastWidth) {
  int tid = threadIdx.x + blockIdx.x * blockDim.x;

  if(tid >= adjRows * adjCols)
    return;

  int rowId = tid / adjRows;
  int colId = tid % adjRows;

  float* b = in + (rowId * inCols) + (colId * width);

  if(colId == adjRows - 1) {
    width = lastWidth;
  }

  float* localMask = mask + (rowId / numKernels) * maskCols + colId * width;
  size_t currentMaxIdx = 0;
  for(int i = 1; i < width; ++i) {
    if(b[i] * localMask[i] > b[currentMaxIdx] * localMask[currentMaxIdx]) {
      currentMaxIdx = i;
    }
  }

  adjIn[(rowId * inCols) + (colId * width) + currentMaxIdx]
      += adj[rowId + (colId * adjCols)];
}

void PoolingWithMaskingBackward(Tensor adj,
                                Tensor adjIn,
                                Tensor in,
                                Tensor mask,
                                int width,
                                bool isEven) {
  int n = adj->shape().elements();
  int threads = std::min(n, 512);
  int blocks = n / threads + (n % threads != 0);

  auto& inShape = in->shape();
  int inRows = inShape[0] * inShape[1];
  int inCols = inShape[2];

  auto& adjShape = adj->shape();
  int adjRows = adjShape[2];
  int adjCols = adjShape[0] * adjShape[1];

  int lastWidth
      = ((inCols - isEven) % width == 0) ? width : (inCols - isEven) % width;

  gMaxPoolingBackward<<<blocks, threads>>>(adj->data(),
                                           adjRows,
                                           adjCols,
                                           in->data(),
                                           adjIn->data(),
                                           inRows,
                                           inCols,
                                           mask->data(),
                                           adjShape[1],
                                           mask->shape()[2],
                                           width,
                                           lastWidth);
}
}  // namespace gpu
}  // namespace marian
