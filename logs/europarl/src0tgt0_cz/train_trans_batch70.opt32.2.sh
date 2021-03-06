marian_home=/home/big_maggie/usr/marian_prometheus/marian_1.7.0/marian-dev/build
$marian_home/marian \
    --model model/model.src0tgt0.trans.batch70.opt64.2.npz --type transformer \
    --train-sets corp/europarl.cs-en.docs.train.en.bpe corp/europarl.cs-en.docs.train.cz.bpe  \
    --max-length 80 \
    --vocabs corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml \
    --mini-batch 70 --maxi-batch 1000 \
    --early-stopping 15 \
    --valid-freq 15000 --save-freq 15000 --disp-freq 1000 \
    --valid-metrics cross-entropy perplexity translation \
    --valid-sets corp/europarl.cs-en.docs.dev.en.bpe corp/europarl.cs-en.docs.dev.cz.bpe \
    --valid-script-path ./val.sh \
    --valid-translation-output data/valid32.bpe.en.output --quiet-translation \
    --valid-mini-batch 16 \
    --beam-size 6 --normalize 0.6 \
    --log model/train_trans.log --valid-log model/valid_trans.log \
    --enc-depth 6 --dec-depth 6 \
    --transformer-heads 8 \
    --transformer-postprocess-emb d \
    --transformer-postprocess dan \
    --transformer-dropout 0.1 --label-smoothing 0.1 \
    --learn-rate 0.0003 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report \
    --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 \
    --tied-embeddings-all --optimizer-delay 64\
    --devices 0 --sync-sgd --seed 1111 \
    --exponential-smoothing

