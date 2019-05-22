marian_home=/home/big_maggie/usr/marian_spider/marian_1.7.6/marian-dev/build
marian_home=/mnt/minerva1/nlp/projects/nmt/marian-dev/build
$marian_home/marian \
    --model model/model.src1tgt0_to_tgt1.concat2.npz --type transformer \
    --train-sets corp/europarl.cs-en.docs.train.en.bpe corp/europarl.cs-en.docs.train.cz.bpe  \
    --max-length 160 --dim-vocabs 30000 30000 \
    --vocabs corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml \
    --mini-batch-fit -w 8700  --mini-batch 1000 --maxi-batch 1000 \
    --early-stopping 10 \
    --valid-freq 5000 --save-freq 5000 --disp-freq 500 \
    --valid-metrics cross-entropy perplexity translation \
    --valid-sets corp/europarl.cs-en.docs.dev.en.bpe corp/europarl.cs-en.docs.dev.cz.bpe \
    --valid-script-path ./val.sh \
    --valid-translation-output data/valid.bpe.en.output --quiet-translation \
    --valid-mini-batch 16 \
    --beam-size 6 --normalize 0.6 \
    --log model/train_trans.concat.log --valid-log model/valid_trans.concat.log \
    --enc-depth 6 --dec-depth 6 \
    --transformer-heads 8 \
    --transformer-postprocess-emb d \
    --transformer-postprocess dan \
    --transformer-dropout 0.1 --label-smoothing 0.1 \
    --learn-rate 0.0002 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report \
    --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 \
    --tied-embeddings-all --optimizer-delay 10\
    --devices 0   --sync-sgd --seed 1111  --keep-best --overwrite \
    --exponential-smoothing --no-restore-corpus --no-nccl 
