marian_home=/home/big_maggie/usr/marian_spider/marian_1.7.6/marian-dev/build
marian_home=/home/large/data/models/marian/marian-doc/marian-dev/build
$marian_home/marian \
    --model model/model.src1tgt0.doc.gate.diff_emb2.npz --type transformer-context \
    --train-sets corp/europarl.cs-en.docs.train.en.bpe.src_prev corp/europarl.cs-en.docs.train.en.bpe.src corp/europarl.cs-en.docs.train.cz.bpe  \
    --max-length 100 --dim-vocabs 30000 30000 \
    --vocabs corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml \
    --mini-batch-fit -w 8900  --mini-batch 1000 --maxi-batch 1000 \
    --early-stopping 10 \
    --valid-freq 5000 --save-freq 5000 --disp-freq 500 \
    --valid-metrics cross-entropy perplexity translation \
    --valid-sets corp/europarl.cs-en.docs.dev.en.bpe.src_prev corp/europarl.cs-en.docs.dev.en.bpe.src corp/europarl.cs-en.docs.dev.cz.bpe \
    --valid-script-path ./val.sh \
    --valid-translation-output data/valid.bpe.en.output --quiet-translation \
    --valid-mini-batch 16 \
    --beam-size 6 --normalize 0.6 \
    --log model/train_trans.doc.log --valid-log model/valid_trans.doc.log \
    --enc-depth 6 --dec-depth 6 \
    --transformer-heads 8 \
    --transformer-postprocess-emb d \
    --transformer-postprocess dan \
    --transformer-dropout 0.1 --label-smoothing 0.1 \
    --learn-rate 0.0003 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report \
    --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 \
    --tied-embeddings-all \
    --devices  0 1 --sync-sgd --seed 1111 \
    --exponential-smoothing --no-restore-corpus  
