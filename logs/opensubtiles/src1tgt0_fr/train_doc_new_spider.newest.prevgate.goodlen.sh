marian_home=/home/big_maggie/usr/marian_prometheus/marian_1.7.5/marian-dev/build
marian_home=/home/big_maggie/usr/marian_metis/marian_1.7.3/marian-dev/build
marian_home=/home/large/data/models/marian/marian-doc/same_emb_no_transpose_run1/marian-dev/build/
marian_home=/home/large/data/models/marian/marian-doc/same_emb_no_transpose_run2/marian-dev/build/
marian_home=/home/large/data/models/marian/marian-doc/doc-marian3_metis_prev_gate/build
$marian_home/marian \
    --model model/model.src1tgt0.doc.new.spider.prevgate.withgate.len110.npz --pretrained-model ../src0tgt0_fr/model/model.src0tgt0.newvocab.iter630000.npz  --type transformer-context \
    --train-sets corp/opensub.en-fr.docs.train.en.bpe.src_prev corp/opensub.en-fr.docs.train.en.bpe.src corp/opensub.en-fr.docs.train.fr.bpe  \
    --max-length 110 --dim-vocabs 30000 30000  --freeze --embedding-fix-src --embedding-fix-trg --context-gate \
    --vocabs corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml \
    --mini-batch-fit -w 8600  --mini-batch 1000 --maxi-batch 1000 \
    --early-stopping 10 \
    --valid-freq 5000 --save-freq 5000 --disp-freq 500 \
    --valid-metrics cross-entropy perplexity translation \
    --valid-sets corp/opensub.en-fr.docs.dev.en.bpe.src_prev corp/opensub.en-fr.docs.dev.en.bpe.src corp/opensub.en-fr.docs.dev.fr.bpe \
    --valid-script-path ./val.sh \
    --valid-translation-output data/valid.bpe.en.output --quiet-translation \
    --valid-mini-batch 64 \
    --beam-size 6 --normalize 0.6 \
    --log model/train_trans.gate.log --valid-log model/valid_trans.gate.log \
    --enc-depth 6 --dec-depth 6 --context-enc-depth 1 \
    --transformer-heads 8 \
    --transformer-postprocess-emb d \
    --transformer-postprocess dan \
    --transformer-dropout 0.1 --label-smoothing 0.1 \
    --learn-rate 0.0002 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report \
    --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 \
    --tied-embeddings-all --optimizer-delay 8\
    --devices 0 --sync-sgd --seed 1111 \
    --exponential-smoothing --no-restore-corpus #--no-shuffle

