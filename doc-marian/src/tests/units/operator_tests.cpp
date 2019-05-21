#include "catch.hpp"
#include "graph/expression_graph.h"
#include "graph/expression_operators.h"
#include <cmath>

using namespace marian;

void tests(DeviceType device) {
  auto floatApprox = [](float x, float y) -> bool { return x == Approx(y); };
  auto floatEqual  = [](float x, float y) -> bool { return x == y; };

  Config::seed = 1234;

  auto graph = New<ExpressionGraph>();
  graph->setDevice({0, device});
  graph->reserveWorkspaceMB(16);

  std::vector<float> values, values2;

  SECTION("scalar multiplication") {
    graph->clear();
    values.clear();
    std::vector<float> vB({1, 2, 3, 4, 5, 6});

    auto B = graph->param("B", {3, 2}, inits::from_vector(vB));
    auto B2 = B * 2.0f;
    graph->forward();

    CHECK(B2->shape() == Shape({3, 2}));
    B2->val()->get(values);

    std::vector<float> vB2({2, 4, 6, 8, 10, 12});
    CHECK(values == vB2);
  }

  SECTION("elementwise binary operators with broadcasting") {
    graph->clear();
    values.clear();

    std::vector<float> vA({1, -2, 3, -4});
    std::vector<float> vB({0.5, 1.5});

    auto a = graph->constant({2, 2, 1}, inits::from_vector(vA));
    auto b = graph->constant({2, 1}, inits::from_vector(vB));

    auto compare = [&](Expr res, std::function<float(float,float)> f, bool exactMatch) -> bool {
      if (res->shape() != Shape({ 2, 2, 1 }))
          return false;
      res->val()->get(values);
      std::vector<float> ref{f(vA[0], vB[0]), f(vA[1], vB[1]), f(vA[2], vB[0]), f(vA[3], vB[1])};
      return std::equal(values.begin(), values.end(), ref.begin(), exactMatch ? floatEqual : floatApprox);
    };

    auto rplus  = a + b;
    auto rminus = a - b;
    auto rmult  = a * b;
    auto rdiv   = a / b;
    auto rlae   = logaddexp(a, b);
    auto rmax   = maximum(a, b);
    auto rmin   = minimum(a, b);
    auto rlt    = lt(a, b);
    auto req    = eq(a, b);
    auto rgt    = gt(a, b);
    auto rge    = ge(a, b);
    auto rne    = ne(a, b);
    auto rle    = le(a, b);

    graph->forward();

    CHECK(compare(rplus,  [](float a, float b) {return a + b;}, true));
    CHECK(compare(rminus, [](float a, float b) {return a - b;}, true));
    CHECK(compare(rmult,  [](float a, float b) {return a * b;}, true));
    CHECK(compare(rdiv,   [](float a, float b) {return a / b;}, /*exactMatch=*/false));
    CHECK(compare(rlae,   [](float a, float b) {return logf(expf(a) + expf(b));}, /*exactMatch=*/false));
    CHECK(compare(rmax,   [](float a, float b) {return std::max(a, b);}, true));
    CHECK(compare(rmin,   [](float a, float b) {return std::min(a, b);}, true));
    CHECK(compare(rlt,    [](float a, float b) {return a <  b;}, true));
    CHECK(compare(req,    [](float a, float b) {return a == b;}, true));
    CHECK(compare(rgt,    [](float a, float b) {return a >  b;}, true));
    CHECK(compare(rge,    [](float a, float b) {return a >= b;}, true));
    CHECK(compare(rne,    [](float a, float b) {return a != b;}, true));
    CHECK(compare(rle,    [](float a, float b) {return a <= b;}, true));
  }

  SECTION("transposing and reshaping") {
    graph->clear();
    values.clear();

    std::vector<float> vA({1, 2, 3, 4, 5, 6, 7, 8});

    std::vector<float> vT1({1, 5, 2, 6, 3, 7, 4, 8});
    std::vector<float> vT3({1, 2, 5, 6, 3, 4, 7, 8});
    std::vector<float> vT4({1, 5, 3, 7, 2, 6, 4, 8});
    std::vector<float> vT5({1, 2, 5, 6, 3, 4, 7, 8});

    auto a = graph->constant({2, 4}, inits::from_vector(vA));

    auto t1 = transpose(a);
    auto t2 = transpose(t1);
    auto t3 = transpose(reshape(t1, {2, 2, 2}));

    auto t4 = transpose(reshape(a, {2, 1, 2, 2}), {1, 3, 2, 0});
    auto t5 = transpose(reshape(a, {2, 1, 2, 2}), {2, 0, 1, 3});

    auto t6 = stopGradient(a);

    graph->forward();

    CHECK(t1->shape() == Shape({4, 2}));
    CHECK(t2->shape() == Shape({2, 4}));
    CHECK(t3->shape() == Shape({2, 2, 2}));
    CHECK(t4->shape() == Shape({1, 2, 2, 2}));
    CHECK(t5->shape() == Shape({2, 2, 1, 2}));
    CHECK(t6->shape() == a->shape());

    t1->val()->get(values);
    CHECK( values == vT1 );

    t2->val()->get(values);
    CHECK( values == vA );

    t3->val()->get(values);
    CHECK( values == vT3 );

    t4->val()->get(values);
    CHECK( values == vT4 );

    t5->val()->get(values);
    CHECK( values == vT5 );

    t6->val()->get(values);
    CHECK(values == vA);
    CHECK(!t6->trainable());
  }

  SECTION("softmax and logsoftmax") {
    graph->clear();
    values.clear();
    std::vector<float> in({-.2, -.3, 4.5, 5.2, -10, 101.45, -100.05, 1.05e-5});

    std::vector<float> smOut({ 0.52498f, 0.47502f, 0.33181f, 0.66819f,
                               0.0f, 1.0f, 0.0f, 1.0f });

    std::vector<float> lsmOut({ -0.6444f, -0.7444f, -1.10319f, -0.40319f,
                                -111.45f, 0.0f, -100.05001f, 0.0f });

    auto input = graph->constant({2, 2, 2}, inits::from_vector(in));

    auto sm  = softmax(input);
    auto lsm = logsoftmax(input);

    graph->forward();

    CHECK(sm->shape() == Shape({2, 2, 2}));
    CHECK(lsm->shape() == Shape({2, 2, 2}));

    sm->val()->get(values);

    CHECK( std::equal(values.begin(), values.end(),
                        smOut.begin(), floatApprox) );

    lsm->val()->get(values);

    CHECK( std::equal(values.begin(), values.end(),
                        lsmOut.begin(), floatApprox) );
  }

  SECTION("layer normalization") {
    graph->clear();
    values.clear();

#ifdef CUDA_FOUND
    std::vector<float> vLn({
      -1.1962, 1.43061, 0.380288, -0.614697, 0.816638, 0.622649,
      -1.69679, 0.257504, -1.12563, -0.151387, 1.61181, -0.334796,
      1.07207, -0.622614, 0.862014, -1.31147
    });
#else
    std::vector<float> vLn({
      -1.49821, -0.152206, 0.394932, 1.25548, -1.51701, -0.28032,
      0.9483, 0.849025, 0.855183, 1.11657, -0.788354, -1.1834,
      -0.85939, -1.13109, 0.972076, 1.01841
    });
#endif

    auto a = graph->constant({2, 2, 4}, inits::glorot_uniform);

    auto gamma = graph->param("gamma", {1, 4}, inits::ones);
    auto beta = graph->param("beta", {1, 4}, inits::zeros);

    auto ln = layerNorm(a, gamma, beta);

    graph->forward();

    CHECK(ln->shape() == Shape({2, 2, 4}));

    ln->val()->get(values);
    CHECK( std::equal(values.begin(), values.end(),
                      vLn.begin(), floatApprox) );

  }

  SECTION("reductions") {
    graph->clear();
    values.clear();

    std::vector<float> vA({1, 6, 3, 8,
                           5, 2, 7, 4});
    // import numpy as np
    // a = np.array([[1, 6, 3, 8], [5, 2, 7, 4]])
    std::vector<float> vS1({6, 8, 10, 12});              // s1 = np.sum(a, axis=0)
    std::vector<float> vS2({18, 18});                    // np.sum(a, axis = 1)
    std::vector<float> vS4({2.6925824f, 1.80277564f});   // np.std(a, axis = 1)
    std::vector<float> vV5({7.25, 3.25});                // np.var(a, axis = 1)
    std::vector<float> vM6({8, 7});                      // np.max(a, axis = 1)
    std::vector<float> vM7({1, 2});                      // np.min(a, axis = 1)
    std::vector<float> vP8({144, 280});                  // np.prod(a, axis = 1)
    std::vector<float> vL9({8.13364336f, 7.17551536f});  // np.log(np.sum(np.exp(a), axis=1))
    std::vector<float> vW({5.0f, 4.55555556f});          // np.mean(a*s1,axis=-1) / np.mean(s1,axis=-1)

    auto a = graph->constant({2, 4}, inits::from_vector(vA));

    auto s1 = sum(a, /*axis=*/ 0);
    auto s2 = sum(a, /*axis=*/ 1);

    auto m3 = mean(s1, /*axis=*/ 1);

    auto s4 = marian::std(a, /*axis=*/ 1);
    auto v5 = var(a, /*axis=*/ 1);

    auto m6 = max(a, /*axis=*/ 1);
    auto m7 = min(a, /*axis=*/ 1);
    auto p8 = prod(a, /*axis=*/ 1);
    auto l9 = logsumexp(a, /*axis=*/ 1);

    auto sp = scalar_product(s2, s2, /*axis=*/ 0);

    auto wa = weighted_average(a, s1, /*axis=*/ -1);

    graph->forward();

    CHECK(s1->shape() == Shape({1, 4}));
    CHECK(s2->shape() == Shape({2, 1}));
    CHECK(m3->shape() == Shape({1, 1}));
    CHECK(s4->shape() == Shape({2, 1}));
    CHECK(v5->shape() == Shape({2, 1}));
    CHECK(m6->shape() == Shape({2, 1}));
    CHECK(m7->shape() == Shape({2, 1}));
    CHECK(p8->shape() == Shape({2, 1}));
    CHECK(l9->shape() == Shape({2, 1}));
    CHECK(sp->shape() == Shape({1, 1}));
    CHECK(wa->shape() == Shape({2, 1}));

    s1->val()->get(values); CHECK(values == vS1);
    s2->val()->get(values); CHECK(values == vS2);

    CHECK(m3->val()->scalar() == 9);

    s4->val()->get(values); CHECK(std::equal(values.begin(), values.end(), vS4.begin(), floatApprox));
    v5->val()->get(values); CHECK(values == vV5);
    m6->val()->get(values); CHECK(values == vM6);
    m7->val()->get(values); CHECK(values == vM7);
    p8->val()->get(values); CHECK(values == vP8);
    l9->val()->get(values); CHECK(std::equal(values.begin(), values.end(), vL9.begin(), floatApprox));

    CHECK(sp->val()->scalar() == 648);

    wa->val()->get(values); CHECK(std::equal(values.begin(), values.end(), vW.begin(), floatApprox));
  }

  SECTION("concatenation") {
    graph->clear();
    values.clear();

    std::vector<float> vO1({ 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2,
                             3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4,
                             1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2,
                             3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4});

    std::vector<float> vO2({1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4,
                            1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4,
                            1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4,
                            1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4});

    std::vector<float> vO3({1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                            2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                            3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
                            4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4});

    std::vector<float> vO4({1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                            2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                            3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
                            4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4});

    auto in1 = graph->constant({1, 2, 2, 3}, inits::from_value(1));
    auto in2 = graph->constant({1, 2, 2, 3}, inits::from_value(2));
    auto in3 = graph->constant({1, 2, 2, 3}, inits::from_value(3));
    auto in4 = graph->constant({1, 2, 2, 3}, inits::from_value(4));

    auto c1out1 = concatenate({in1, in2, in3, in4}, /*axis=*/ 2);
    auto c1out2 = concatenate({in1, in2, in3, in4}, /*axis=*/ -1);
    auto c1out3 = concatenate({in1, in2, in3, in4}, /*axis=*/ -3);
    auto c1out4 = concatenate({in1, in2, in3, in4}, /*axis=*/ 0);

    graph->forward();

    CHECK(c1out1->shape() == Shape({1, 2, 8, 3}));
    CHECK(c1out2->shape() == Shape({1, 2, 2, 12}));
    CHECK(c1out3->shape() == Shape({1, 8, 2, 3}));
    CHECK(c1out4->shape() == Shape({4, 2, 2, 3}));

    c1out1->val()->get(values);
    CHECK( values == vO1 );

    c1out2->val()->get(values);
    CHECK( values == vO2 );

    c1out3->val()->get(values);
    CHECK( values == vO3 );

    c1out4->val()->get(values);
    CHECK( values == vO4 );
  }

  SECTION("dot product") {
    graph->clear();
    values.clear();

    std::vector<float> vA({1, 2, 3,
                           4, 5, 6,
                           7, 8, 9,
                           10, 11, 12});
    std::vector<float> vB({1, 2,
                           3, 4,
                           5, 6});
    std::vector<float> vC({22, 28,
                           49, 64,
                           76, 100,
                           103, 136});

    auto A = graph->param("A", {2, 2, 3}, inits::from_vector(vA));
    auto B = graph->param("B", {3, 2}, inits::from_vector(vB));
    auto C = dot(A, B);

    CHECK(C->shape() == Shape({2, 2, 2}));

    graph->forward();

    C->val()->get(values);
    CHECK(values == vC);
  }

  if(device == DeviceType::gpu) {
    SECTION("csr-dot product") {
      graph->clear();
      values.clear();
      // CSR dot product, tested against dense product on the same values
      std::vector<float> vS({1, 0, 0, 1,          // sparse
                            0, 0, 1, 1.5});
      std::vector<float> vD({1, 2, 3, 1.2, 5.6,   // dense
                            4, 5, 6, 2.3, 6.7,
                            7, 8, 9, 3.4, 7.8,
                            1, 1, 2, 4.5, 8.9});
      auto S  = graph->param("S",  { 2, 4 }, inits::from_vector(vS));
      auto D  = graph->param("D",  { 4, 5 }, inits::from_vector(vD));
      auto DT = graph->param("DT", { 5, 4 }, inits::from_vector(vD)); // example matrix with transposed dimensions
      std::vector<float> SV;    // create CSR version of S
      std::vector<IndexType> SI, SO;
      SO.push_back((IndexType)SI.size());
      for (IndexType i = 0; i < S->shape()[0]; i++) {
        for (IndexType j = 0; j < S->shape()[1]; j++) {
          auto k = 4 * i + j;
          if (vS[k] != 0) {
            SV.push_back(vS[k]);
            SI.push_back(j);
          }
        }
        SO.push_back((IndexType)SI.size());
      }

      auto SxDd    = dot(S, D);
      auto STxSxDd = dot(S, SxDd, /*transA=*/true);
      auto SxDs = csr_dot( // sparse x dense
            S->shape(),
            graph->constant({(int)SV.size()}, inits::from_vector(SV), Type::float32),
            graph->constant({(int)SI.size()}, inits::from_vector(SI), Type::uint32),
            graph->constant({(int)SO.size()}, inits::from_vector(SO), Type::uint32),
            D);
      auto STxSxDs = csr_dot(   // transpose(sparse) x dense; we use result of previous since dimensions match
            S->shape(),
            graph->constant({(int)SV.size()}, inits::from_vector(SV), Type::float32),
            graph->constant({(int)SI.size()}, inits::from_vector(SI), Type::uint32),
            graph->constant({(int)SO.size()}, inits::from_vector(SO), Type::uint32),
            SxDd, /*transS=*/true);

      auto DTxSTd   = dot(DT,     S, /*transA=*/false, /*transB=*/true);
      auto DTxSTxSd = dot(DTxSTd, S);
      auto DTxSTs = dot_csr( // dense x sparse
            DT,
            S->shape(),
            graph->constant({(int)SV.size()}, inits::from_vector(SV), Type::float32),
            graph->constant({(int)SI.size()}, inits::from_vector(SI), Type::uint32),
            graph->constant({(int)SO.size()}, inits::from_vector(SO), Type::uint32),
            /*transS=*/true);
      auto DTxSTxSs = dot_csr( // dense x transpose(sparse)
            DTxSTd,
            S->shape(),
            graph->constant({(int)SV.size()}, inits::from_vector(SV), Type::float32),
            graph->constant({(int)SI.size()}, inits::from_vector(SI), Type::uint32),
            graph->constant({(int)SO.size()}, inits::from_vector(SO), Type::uint32));

      CHECK(SxDs->shape() == SxDd->shape());
      CHECK(STxSxDs->shape() == STxSxDd->shape());
      CHECK(DTxSTs->shape() == DTxSTd->shape());
      CHECK(DTxSTxSs->shape() == DTxSTxSd->shape());

      graph->forward();

      // dense and sparse operation results must be the same
      SxDd    ->val()->get(values2); SxDs    ->val()->get(values); CHECK(values == values2);
      STxSxDd ->val()->get(values2); STxSxDs ->val()->get(values); CHECK(values == values2);
      DTxSTd  ->val()->get(values2); DTxSTs  ->val()->get(values); CHECK(values == values2);
      DTxSTxSd->val()->get(values2); DTxSTxSs->val()->get(values); CHECK(values == values2);
    }
  }

  SECTION("affine transformation") {
    graph->clear();
    values.clear();

    std::vector<float> vA({1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12});
    std::vector<float> vB({1, 2, 3, 4, 5, 6});
    std::vector<float> vAff({24, 30, 51, 66, 78, 102, 105, 138});

    auto A = graph->param("A", {4, 3}, inits::from_vector(vA));
    auto B = graph->param("B", {3, 2}, inits::from_vector(vB));
    auto C = graph->param("C", {4, 2}, inits::from_value(2));
    auto aff1 = affine(A, B, C);
    auto aff2 = dot(A, B) + C;
    graph->forward();

    CHECK(aff1->shape() == Shape({4, 2}));
    aff1->val()->get(values);
    CHECK(values == vAff);

    std::vector<float> values2;
    CHECK(aff2->shape() == aff1->shape());
    aff2->val()->get(values2);
    CHECK(values2 == values);
  }

  SECTION("repeat") {
    graph->clear();
    values.clear();

    std::vector<float> vA({1, 2, 3, 4, 5, 6});
    std::vector<float> vB({1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6});
    std::vector<float> vC({1, 2, 3, 1, 2, 3, 4, 5, 6, 4, 5, 6});

    auto A = graph->param("A", {2,3}, inits::from_vector(vA));
    auto I = repeat(A, 1, 0);
    auto B = repeat(A, 2, 0);
    auto C = repeat(A, 2, 1);
    graph->forward();

    CHECK(I->shape() == Shape({2, 3}));
    I->val()->get(values);
    CHECK(values == vA);

    CHECK(B->shape() == Shape({4, 3}));
    B->val()->get(values);
    CHECK(values == vB);

    CHECK(C->shape() == Shape({2, 6}));
    C->val()->get(values);
    CHECK(values == vC);
  }

  SECTION("flatten") {
    graph->clear();
    values.clear();

    std::vector<float> vIn({1, 2, 3, 4, 5, 6, 7, 8});

    auto A = graph->param("A", {2, 4}, inits::from_vector(vIn));
    auto Af = flatten(A);
    auto B = graph->param("B", {2, 2, 1, 2}, inits::from_vector(vIn));
    auto Bf = flatten(B);
    graph->forward();

    CHECK(Af->shape() == Shape({8}));
    Af->val()->get(values);
    CHECK(values == vIn);

    CHECK(Bf->shape() == Shape({8}));
    Bf->val()->get(values);
    CHECK(values == vIn);
  }

  SECTION("rows selection from 2d matrix") {
    graph->clear();
    values.clear();

    std::vector<float> vA({1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12});

    std::vector<IndexType> iB0({0});            // first row
    std::vector<IndexType> iB1({0, 1, 2});      // several consecutive rows
    std::vector<IndexType> iB2({0, 2});         // two nonconsecutive rows
    std::vector<IndexType> iB3({2, 1});         // reversed order
    std::vector<IndexType> iB4({1, 1});         // repeated rows
    std::vector<IndexType> iB5({0, 1, 2, 3});   // identity
    std::vector<IndexType> iB6({});             // empty
    std::vector<float> vB0({1, 2, 3});
    std::vector<float> vB1({1, 2, 3, 4, 5, 6, 7, 8, 9});
    std::vector<float> vB2({1, 2, 3, 7, 8, 9});
    std::vector<float> vB3({7, 8, 9, 4, 5, 6});
    std::vector<float> vB4({4, 5, 6, 4, 5, 6});
    std::vector<float> vB6;

    auto A = graph->param("A", {4, 3}, inits::from_vector(vA));
    auto B0 = rows(A, iB0);
    auto B1 = rows(A, iB1);
    auto B2 = rows(A, iB2);
    auto B3 = rows(A, iB3);
    auto B4 = rows(A, iB4);
    auto B5 = rows(A, iB5);
    auto B6 = rows(A, iB6);
    graph->forward();

    CHECK(B0->shape() == Shape({1, 3}));
    B0->val()->get(values);
    CHECK( values == vB0 );

    CHECK(B1->shape() == Shape({3, 3}));
    B1->val()->get(values);
    CHECK( values == vB1 );

    CHECK(B2->shape() == Shape({2, 3}));
    B2->val()->get(values);
    CHECK( values == vB2 );

    CHECK(B3->shape() == Shape({2, 3}));
    B3->val()->get(values);
    CHECK( values == vB3 );

    CHECK(B4->shape() == Shape({2, 3}));
    B4->val()->get(values);
    CHECK( values == vB4 );

    CHECK(B5->shape() == Shape({4, 3}));
    B5->val()->get(values);
    CHECK( values == vA );

    CHECK(B6->shape() == Shape({0, 3}));
    B6->val()->get(values);
    CHECK( values == vB6 );
  }

  SECTION("columns selection from 2d matrix") {
    graph->clear();
    values.clear();

    std::vector<float> vA({1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12});

    std::vector<IndexType> iB0({0});            // first column
    std::vector<IndexType> iB1({0, 1, 2});      // several consecutive columns
    std::vector<IndexType> iB2({0, 2});         // two nonconsecutive columns
    std::vector<IndexType> iB3({2, 1});         // reversed order
    std::vector<IndexType> iB4({1, 1});         // repeated columns
    std::vector<IndexType> iB5({0, 1, 2, 3});   // identity
    std::vector<IndexType> iB6({});             // empty

    std::vector<float> vB0({1, 5, 9});
    std::vector<float> vB1({1, 2, 3, 5, 6, 7, 9, 10, 11});
    std::vector<float> vB2({1, 3, 5, 7, 9, 11});
    std::vector<float> vB3({3, 2, 7, 6, 11, 10});
    std::vector<float> vB4({2, 2, 6, 6, 10, 10});
    std::vector<float> vB6;

    auto A = graph->param("A", {3, 4}, inits::from_vector(vA));
    auto B0 = cols(A, iB0);
    auto B1 = cols(A, iB1);
    auto B2 = cols(A, iB2);
    auto B3 = cols(A, iB3);
    auto B4 = cols(A, iB4);
    auto B5 = cols(A, iB5);
    auto B6 = cols(A, iB6);
    graph->forward();

    CHECK(B0->shape() == Shape({3, 1}));
    B0->val()->get(values);
    CHECK( values == vB0 );

    CHECK(B1->shape() == Shape({3, 3}));
    B1->val()->get(values);
    CHECK( values == vB1 );

    CHECK(B2->shape() == Shape({3, 2}));
    B2->val()->get(values);
    CHECK( values == vB2 );

    CHECK(B3->shape() == Shape({3, 2}));
    B3->val()->get(values);
    CHECK( values == vB3 );

    CHECK(B4->shape() == Shape({3, 2}));
    B4->val()->get(values);
    CHECK( values == vB4 );

    CHECK(B5->shape() == Shape({3, 4}));
    B5->val()->get(values);
    CHECK( values == vA );

    CHECK(B6->shape() == Shape({3, 0}));
    B6->val()->get(values);
    CHECK( values == vB6 );
  }

  SECTION("relation of rows and columns selection using transpose") {
    graph->clear();
    values.clear();
    std::vector<float> values2;

    std::vector<float> vA({0, .3333, -.2, -.3, 0, 4.5, 5.2, -10, 101.45, -100.05, 0, 1.05e-5});
    std::vector<IndexType> idx({0, 1});

    auto A1 = graph->param("4x3", {4,3}, inits::from_vector(vA));
    auto B1 = rows(transpose(A1), idx);
    auto C1 = transpose(cols(A1, idx));
    auto A2 = graph->param("6x2", {6,2}, inits::from_vector(vA));
    auto B2 = cols(transpose(A2), idx);
    auto C2 = transpose(rows(A2, idx));
    graph->forward();

    CHECK(B1->shape() == C1->shape());
    B1->val()->get(values);
    C1->val()->get(values2);
    CHECK( values == values2 );

    values.clear();
    values2.clear();

    CHECK(B2->shape() == C2->shape());
    B2->val()->get(values);
    C2->val()->get(values2);
    CHECK( values == values2 );
  }

  SECTION("select, step, slice operators") {
    using IndexVector = std::vector<IndexType>;

    graph->clear();
    values.clear();

    std::vector<float> vA({  1, -2,   3,
                            -4,  5,  -6,
                             7, -8,   9,
                           -10, 11, -12});
    std::vector<float> vC({ 1,  -2, // C = np.array([1, -2, 3, -4, 5, -6, 7, -8, 9, -10, 11, -12]).reshape((2, 3, 2))
                            3,  -4,
                            5,  -6,

                            7,  -8,
                            9, -10,
                           11, -12 });
    std::vector<float> vB1({1, -2, 3});
    std::vector<float> vB2({1, -4, 7, -10});
    std::vector<float> vB3({-2, 5, -8, 11});
    std::vector<float> vB4({1, -2, 3, -4, 5, -6});
    std::vector<float> vD1(vB4);
    std::vector<float> vD2({5, -6, 11, -12});
    std::vector<float> vD3({1, -2, 5, -6, 7, -8, 11, -12}); // C[:,(0,2),:]
    //std::vector<float> vD4({5, -6, 3, -4, 7, -8, 11, -12}); // [C[0,(2,1),:],C[1,(0,2),:]]
    std::vector<float> vS1({7, -8, 9});
    std::vector<float> vS2({-4, 5, -6, 7, -8, 9});
    std::vector<float> vS3({7, -8, 9, -10, 11, -12});

    auto A = graph->param("4x3", {4,3}, inits::from_vector(vA));
    auto B1a = index_select(A, 0, IndexVector({0})); // always uses gather()
    auto B1b = slice(A,  0, 0);                        // memory-consecutive view
    auto B2  = slice(A,  1, 0);                        // not memory-consecutive
    auto B3  = slice(A, -1, 1);
    auto B4a = index_select(A, 0, IndexVector({0, 1}));
    auto B4b = slice(A, 0, Slice(0, 2)); // this is memory-consecutive
    auto B5  = slice(A, 0, Slice(0, 4)); // this is a no-op
    CHECK(B1a->type() == "rows");      // actually optimized to rows()
    CHECK(B1b->type() == "sliceView"); // must use view
    CHECK(B2->type() == "gather");     // cannot use view
    CHECK(B4a->type() == "rows");
    CHECK(B4b->type() == "sliceView"); // must use view
    CHECK(B5.get() == A.get());        // must be no-op

    auto C = graph->param("2x3x2", {2, 3, 2}, inits::from_vector(vC));
    auto D1 = slice(C,  0, 0);
    auto D2 = slice(C, -2, 2);
    auto D3 = index_select(C, 1, IndexVector({0, 2})); // C[:,(0,2),:]
    CHECK(D1->type() == "sliceView");
    CHECK(D2->type() == "gather");
    // enable this once gather() supports batched indices:
    //auto D4 = gather(C, 1, graph->constant({2, 2, 1}, // [C[0,(2,1),:],C[1,(0,2),:]]
    //                                       inits::from_vector(std::vector<IndexType>{
    //                                         2, 1,
    //                                         0, 2 }),
    //                                       Type::uint32));

    auto S1 = slice(A, 0, 2);
    auto S2 = narrow(A, 0, 1, 2);
    auto S3 = slice(A, 0, Slice(-2, Slice::END));

    graph->forward();

    CHECK(B1a->shape() == Shape({1, 3})); B1a->val()->get(values); CHECK( values == vB1 );
    CHECK(B1b->shape() == Shape({1, 3})); B1b->val()->get(values); CHECK( values == vB1 );
    CHECK(B2->shape() == Shape({4, 1})); B2->val()->get(values); CHECK( values == vB2 );
    CHECK(B3->shape() == Shape({4, 1})); B3->val()->get(values); CHECK( values == vB3 );
    CHECK(B4a->shape() == Shape({2, 3})); B4a->val()->get(values); CHECK( values == vB4 );
    CHECK(B4b->shape() == Shape({2, 3})); B4b->val()->get(values); CHECK( values == vB4 );

    CHECK(D1->shape() == Shape({1, 3, 2})); D1->val()->get(values); CHECK( values == vD1 );
    CHECK(D2->shape() == Shape({2, 1, 2})); D2->val()->get(values); CHECK( values == vD2 );
    CHECK(D3->shape() == Shape({2, 2, 2})); D3->val()->get(values); CHECK( values == vD3 );
    //CHECK(D4->shape() == Shape({2, 2, 2})); D4->val()->get(values); CHECK( values == vD4 );

    CHECK(S1->shape() == Shape({1,3})); S1->val()->get(values); CHECK(values == vS1);
    CHECK(S2->shape() == Shape({2,3})); S2->val()->get(values); CHECK(values == vS2);
    CHECK(S3->shape() == Shape({2,3})); S3->val()->get(values); CHECK(values == vS3);
  }

  SECTION("rows/cols as gather operations") {
    graph->clear();
    values.clear();
    std::vector<float> values2;

    std::vector<float> vA({0, .3333, -.2, -.3, 0, 4.5, 5.2, -10, 101.45, -100.05, 0, 1.05e-5});
    std::vector<IndexType> indices({0, 2});

    auto A = graph->param("4x3", {4, 3}, inits::from_vector(vA));
    auto B1 = rows(A, indices);
    auto B2 = gather(A, 0, graph->indices(indices, A, 0));
    auto C1 = cols(A, indices);
    auto C2 = gather(A, 1, graph->indices(indices, A, 1));
    graph->forward();

    CHECK(B1->shape() == B2->shape());
    B1->val()->get(values);
    B2->val()->get(values2);
    CHECK( values == values2 );

    CHECK(C1->shape() == C2->shape());
    C1->val()->get(values);
    C2->val()->get(values2);
    CHECK( values == values2 );
  }
}

#ifdef CUDA_FOUND
TEST_CASE("Expression graph supports basic math operations (gpu)", "[operator]") {
  tests(DeviceType::gpu);
}
#endif

#ifdef BLAS_FOUND
TEST_CASE("Expression graph supports basic math operations (cpu)", "[operator]") {
  tests(DeviceType::cpu);
}
#endif
