marian_home=/home/big_maggie/usr/marian_prometheus/marian_1.7.5/marian-dev/build
marian_home=/home/big_maggie/usr/marian_bakchus/marian-dev/build
$marian_home/marian \
    --model model/model.src0tgt0.newvocab.npz --type transformer \
    --train-sets corp/opensub.en-fr.docs.train.en.bpe corp/opensub.en-fr.docs.train.fr.bpe  \
    --max-length 55 --dim-vocabs 30000 30000 \
    --vocabs corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml \
    --mini-batch-fit -w 9000  --mini-batch 1000 --maxi-batch 1000 \
    --early-stopping 10 \
    --valid-freq 5000 --save-freq 5000 --disp-freq 500 \
    --valid-metrics cross-entropy perplexity translation \
    --valid-sets corp/opensub.en-fr.docs.dev.en.bpe corp/opensub.en-fr.docs.dev.fr.bpe \
    --valid-script-path ./val.sh \
    --valid-translation-output data/valid.bpe.en.output --quiet-translation \
    --valid-mini-batch 64 \
    --beam-size 6 --normalize 0.6 \
    --log model/train_trans.nv.log --valid-log model/valid_trans.nv.log \
    --enc-depth 6 --dec-depth 6 \
    --transformer-heads 8 \
    --transformer-postprocess-emb d \
    --transformer-postprocess dan \
    --transformer-dropout 0.1 --label-smoothing 0.1 \
    --learn-rate 0.0003 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report \
    --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 \
    --tied-embeddings-all --optimizer-delay 2 \
    --devices 0 --no-nccl  --sync-sgd --seed 1111 \
    --exponential-smoothing --no-restore-corpus #--no-shuffle

