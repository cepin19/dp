marian_home=/home/big_maggie/usr/marian_spider/marian_1.7.6/marian-dev/build
$marian_home/marian \
    --model model/model.src1tgt0.dual.len.npz --type multi-s2s \
    --train-sets  corp/europarl.cs-en.docs.train.en.bpe.src_prev corp/europarl.cs-en.docs.train.en.bpe.src corp/europarl.cs-en.docs.train.cz.bpe\
    --max-length 100 \
    --vocabs corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml \
    --mini-batch-fit -w 9500 --mini-batch 1000 --maxi-batch 1000 \
    --valid-freq 5000 --save-freq 5000 --disp-freq 500 \
    --valid-metrics ce-mean-words perplexity translation \
    --valid-sets corp/europarl.cs-en.docs.dev.en.bpe.src_prev corp/europarl.cs-en.docs.dev.en.bpe.src corp/europarl.cs-en.docs.dev.cz.bpe \
    --valid-script-path ./val.sh \
    --valid-translation-output data/valid.len.bpe.en.output --quiet-translation \
    --beam-size 6 --normalize=1 \
    --valid-mini-batch 64 \
    --overwrite --keep-best \
    --early-stopping 5 --cost-type=ce-mean-words \
    --log model/train.dual.log --valid-log model/valid.dual.log \
    --enc-type bidirectional --enc-depth 1 --enc-cell-depth 4 \
    --dec-depth 1 --dec-cell-base-depth 8 --dec-cell-high-depth 1 \
    --tied-embeddings-all --layer-normalization \
    --dropout-rnn 0.1 --label-smoothing 0.1 \
    --learn-rate 0.0003 --lr-decay-inv-sqrt 16000 --lr-report \
    --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 \
    --devices 0 1  --sync-sgd --seed 1234  --no-nccl \
    --exponential-smoothing
