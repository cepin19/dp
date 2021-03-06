marian_home=/home/big_maggie/usr/marian_prometheus/marian_1.7.5/marian-dev/build
marian_home=/home/big_maggie/usr/marian_metis/marian_1.7.3/marian-dev/build
#marian_home=/home/large/data/models/marian/marian-doc/same_emb_no_transpose_run1/marian-dev/build/
marian_home=/mnt/minerva1/nlp/projects/nmt/doc-marian/build
$marian_home/marian \
    --model model/model.src1tgt0.from_new_pretrained.context-enc-depth6.npz --pretrained-model model/model.src1tgt0.docnew.enc_depth.test_base.npz.best-perplexity.npz  --type transformer-context \
    --train-sets corp/europarl.cs-en.docs.train.en.bpe.src_prev corp/europarl.cs-en.docs.train.en.bpe.src corp/europarl.cs-en.docs.train.cz.bpe  \
    --max-length 160 --dim-vocabs 30000 30000 --embedding-fix-src --embedding-fix-trg \
    --vocabs corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml \
    --mini-batch-fit -w 7800  --mini-batch 1000 --maxi-batch 1000 \
    --early-stopping 10 --freeze --context-enc-depth 6 \
    --valid-freq 5000 --save-freq 5000 --disp-freq 1000 \
    --valid-metrics cross-entropy perplexity translation \
    --valid-sets corp/europarl.cs-en.docs.dev.en.bpe.src_prev corp/europarl.cs-en.docs.dev.en.bpe.src corp/europarl.cs-en.docs.dev.cz.bpe \
    --valid-script-path ./val.sh \
    --valid-translation-output data/valid.bpe.en.output --quiet-translation \
    --valid-mini-batch 16 --keep-best  \
    --beam-size 6 --normalize 0.6 \
    --log model/train_trans.gate.log --valid-log model/valid_trans.gate.log \
    --enc-depth 6 --dec-depth 6 \
    --transformer-heads 8 \
    --transformer-postprocess-emb d \
    --transformer-postprocess dan \
    --transformer-dropout 0.1 --label-smoothing 0.1 \
    --learn-rate 0.0001 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report \
    --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 \
    --tied-embeddings-all --optimizer-delay 4\
    --devices 0  --no-nccl  --sync-sgd --seed 1111 \
    --exponential-smoothing --no-restore-corpus #--no-shuffle

