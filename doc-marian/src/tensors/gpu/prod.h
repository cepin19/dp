#pragma once

#include "tensors/tensor.h"
#include "tensors/tensor_operators.h"

#include "functional/functional.h"

namespace marian {
namespace gpu {

void Prod(marian::Tensor C,
          const marian::Tensor& A,
          const marian::Tensor& B,
          bool transA,
          bool transB,
          float beta = 0,
          float scalar = 1);

void ProdWithBias(marian::Tensor C,
                  const marian::Tensor& A,
                  const marian::Tensor& B,
                  const marian::Tensor& bias,
                  bool transA,
                  bool transB,
                  float beta = 0,
                  float scalar = 1);

void ProdBatched(marian::Tensor C,
                 Ptr<Allocator> allocator,
                 const marian::Tensor A,
                 const marian::Tensor B,
                 bool transA,
                 bool transB,
                 float beta = 0,
                 float scalar = 1);
void CSRProd(marian::Tensor C,
             Ptr<Allocator> allocator,
             const marian::Tensor& A_values,
             const marian::Tensor& A_indices,
             const marian::Tensor& A_offsets,
             const marian::Tensor& B,
             bool transA,
             bool swapOperands,
             float beta = 0);
}  // namespace gpu
}  // namespace marian
