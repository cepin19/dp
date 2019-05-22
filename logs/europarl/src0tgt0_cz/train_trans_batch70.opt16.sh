marian_home=/home/big_maggie/usr/marian_cosmas/marian_1.6.0/marian-dev/build
$marian_home/marian \
    --model model/model.src0tgt0.trans.batch70.opt16.npz --type transformer \
    --train-sets corp/europarl.cs-en.docs.train.en.bpe corp/europarl.cs-en.docs.train.cz.bpe  \
    --max-length 80 \
    --vocabs corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml \
    --mini-batch 70 --maxi-batch 1000 \
    --early-stopping 10 \
    --valid-freq 5000 --save-freq 5000 --disp-freq 500 \
    --valid-metrics cross-entropy perplexity translation \
    --valid-sets corp/europarl.cs-en.docs.dev.en.bpe corp/europarl.cs-en.docs.dev.cz.bpe \
    --valid-script-path ./val.sh \
    --valid-translation-output data/valid.bpe.en.output --quiet-translation \
    --valid-mini-batch 64 \
    --beam-size 6 --normalize 0.6 \
    --log model/train_trans.log --valid-log model/valid_trans.log \
    --enc-depth 6 --dec-depth 6 \
    --transformer-heads 8 \
    --transformer-postprocess-emb d \
    --transformer-postprocess dan \
    --transformer-dropout 0.1 --label-smoothing 0.1 \
    --learn-rate 0.0003 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report \
    --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 \
    --tied-embeddings-all --optimizer-delay 16\
    --devices 2 --sync-sgd --seed 1111 \
    --exponential-smoothing

