#!/bin/bash
marian_home=/home/big_maggie/usr/marian_cosmas/marian_1.6.0/marian-dev/build
$marian_home/marian \
    --model model/model_base.npz --type s2s \
    --train-sets corp/train_base.cs.bpe corp/train_base.en.bpe \
    --max-length 100 \
    --vocabs corp/vocab.encs.yml corp/vocab.encs.yml \
    --mini-batch-fit -w 7500 --maxi-batch 1000 \
    --early-stopping 10 \
    --beam-size 6 --normalize 0.6 \
    --log model/train.log --valid-log model/valid.log \
    --enc-type bidirectional --enc-depth 1 --enc-cell-depth 4 \
    --dec-depth 1 --dec-cell-base-depth 8 --dec-cell-high-depth 1 \
    --tied-embeddings-all --layer-normalization \
    --dropout-rnn 0.1 --label-smoothing 0.1 \
    --learn-rate 0.0003 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report \
    --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 \
    --devices 2 --sync-sgd --seed 1111 \
    --valid-freq 15000 --save-freq 15000 --disp-freq 1000 \
    --valid-metrics cross-entropy perplexity translation \
    --valid-sets corp/newstest2016-encs-src.cs.bpe corp/newstest2016-encs-ref.en.bpe \
    --valid-script-path ./val.csen.sh \
    --valid-translation-output valid.bpe.en.output  \
    --valid-mini-batch 64 --dim-vocabs 30000 30000 --keep-best --sqlite 
