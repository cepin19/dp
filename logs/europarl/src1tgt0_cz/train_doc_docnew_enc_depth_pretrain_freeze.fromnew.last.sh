[2019-04-02 03:32:13] [marian] Marian v1.7.8 b59f01a 2019-04-02 03:22:27 +0200
[2019-04-02 03:32:13] [marian] Running on pcknot5 as process 32749 with command line:
[2019-04-02 03:32:13] [marian] /mnt/minerva1/nlp/projects/nmt/doc-marian/build/marian --model model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz --pretrained-model model/model.src1tgt0.docnew.enc_depth.test_base.npz.best-perplexity.npz --type transformer-context --train-sets corp/europarl.cs-en.docs.train.en.bpe.src_prev corp/europarl.cs-en.docs.train.en.bpe.src corp/europarl.cs-en.docs.train.cz.bpe --max-length 160 --dim-vocabs 30000 30000 --embedding-fix-src --embedding-fix-trg --vocabs corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml --mini-batch-fit -w 7800 --mini-batch 1000 --maxi-batch 1000 --early-stopping 10 --freeze --valid-freq 5000 --save-freq 1000 --disp-freq 1000 --valid-metrics cross-entropy perplexity translation --valid-sets corp/europarl.cs-en.docs.dev.en.bpe.src_prev corp/europarl.cs-en.docs.dev.en.bpe.src corp/europarl.cs-en.docs.dev.cz.bpe --valid-script-path ./val.sh --valid-translation-output data/valid.bpe.en.output --quiet-translation --valid-mini-batch 16 --keep-best --beam-size 6 --normalize 0.6 --log model/train_trans.gate.log --valid-log model/valid_trans.gate.log --enc-depth 6 --dec-depth 6 --transformer-heads 8 --transformer-postprocess-emb d --transformer-postprocess dan --transformer-dropout 0.1 --label-smoothing 0.1 --learn-rate 0.0001 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 --tied-embeddings-all --optimizer-delay 4 --devices 0 --no-nccl --sync-sgd --seed 1111 --exponential-smoothing --no-restore-corpus
[2019-04-02 03:32:13] [config] after-batches: 0
[2019-04-02 03:32:13] [config] after-epochs: 0
[2019-04-02 03:32:13] [config] allow-unk: false
[2019-04-02 03:32:13] [config] beam-size: 6
[2019-04-02 03:32:13] [config] bert-class-symbol: "[CLS]"
[2019-04-02 03:32:13] [config] bert-mask-symbol: "[MASK]"
[2019-04-02 03:32:13] [config] bert-masking-fraction: 0.15
[2019-04-02 03:32:13] [config] bert-sep-symbol: "[SEP]"
[2019-04-02 03:32:13] [config] bert-train-type-embeddings: true
[2019-04-02 03:32:13] [config] bert-type-vocab-size: 2
[2019-04-02 03:32:13] [config] best-deep: false
[2019-04-02 03:32:13] [config] clip-gemm: 0
[2019-04-02 03:32:13] [config] clip-norm: 5
[2019-04-02 03:32:13] [config] context-enc-depth: 1
[2019-04-02 03:32:13] [config] cost-type: ce-mean
[2019-04-02 03:32:13] [config] cpu-threads: 0
[2019-04-02 03:32:13] [config] data-weighting: ""
[2019-04-02 03:32:13] [config] data-weighting-type: sentence
[2019-04-02 03:32:13] [config] dec-cell: gru
[2019-04-02 03:32:13] [config] dec-cell-base-depth: 2
[2019-04-02 03:32:13] [config] dec-cell-high-depth: 1
[2019-04-02 03:32:13] [config] dec-depth: 6
[2019-04-02 03:32:13] [config] devices:
[2019-04-02 03:32:13] [config]   - 0
[2019-04-02 03:32:13] [config] dim-emb: 512
[2019-04-02 03:32:13] [config] dim-rnn: 1024
[2019-04-02 03:32:13] [config] dim-vocabs:
[2019-04-02 03:32:13] [config]   - 30000
[2019-04-02 03:32:13] [config]   - 30000
[2019-04-02 03:32:13] [config]   - 30000
[2019-04-02 03:32:13] [config] disp-first: 0
[2019-04-02 03:32:13] [config] disp-freq: 1000
[2019-04-02 03:32:13] [config] disp-label-counts: false
[2019-04-02 03:32:13] [config] dropout-rnn: 0
[2019-04-02 03:32:13] [config] dropout-src: 0
[2019-04-02 03:32:13] [config] dropout-trg: 0
[2019-04-02 03:32:13] [config] dump-config: ""
[2019-04-02 03:32:13] [config] early-stopping: 10
[2019-04-02 03:32:13] [config] embedding-fix-src: true
[2019-04-02 03:32:13] [config] embedding-fix-trg: true
[2019-04-02 03:32:13] [config] embedding-normalization: false
[2019-04-02 03:32:13] [config] embedding-vectors:
[2019-04-02 03:32:13] [config]   []
[2019-04-02 03:32:13] [config] enc-cell: gru
[2019-04-02 03:32:13] [config] enc-cell-depth: 1
[2019-04-02 03:32:13] [config] enc-depth: 6
[2019-04-02 03:32:13] [config] enc-type: bidirectional
[2019-04-02 03:32:13] [config] exponential-smoothing: 0.0001
[2019-04-02 03:32:13] [config] freeze: true
[2019-04-02 03:32:13] [config] grad-dropping-momentum: 0
[2019-04-02 03:32:13] [config] grad-dropping-rate: 0
[2019-04-02 03:32:13] [config] grad-dropping-warmup: 100
[2019-04-02 03:32:13] [config] guided-alignment: none
[2019-04-02 03:32:13] [config] guided-alignment-cost: mse
[2019-04-02 03:32:13] [config] guided-alignment-weight: 0.1
[2019-04-02 03:32:13] [config] hier-att: false
[2019-04-02 03:32:13] [config] ignore-model-config: false
[2019-04-02 03:32:13] [config] input-types:
[2019-04-02 03:32:13] [config]   []
[2019-04-02 03:32:13] [config] interpolate-env-vars: false
[2019-04-02 03:32:13] [config] keep-best: true
[2019-04-02 03:32:13] [config] label-smoothing: 0.1
[2019-04-02 03:32:13] [config] layer-normalization: false
[2019-04-02 03:32:13] [config] learn-rate: 0.0001
[2019-04-02 03:32:13] [config] log: model/train_trans.gate.log
[2019-04-02 03:32:13] [config] log-level: info
[2019-04-02 03:32:13] [config] log-time-zone: ""
[2019-04-02 03:32:13] [config] lr-decay: 0
[2019-04-02 03:32:13] [config] lr-decay-freq: 50000
[2019-04-02 03:32:13] [config] lr-decay-inv-sqrt:
[2019-04-02 03:32:13] [config]   - 16000
[2019-04-02 03:32:13] [config] lr-decay-repeat-warmup: false
[2019-04-02 03:32:13] [config] lr-decay-reset-optimizer: false
[2019-04-02 03:32:13] [config] lr-decay-start:
[2019-04-02 03:32:13] [config]   - 10
[2019-04-02 03:32:13] [config]   - 1
[2019-04-02 03:32:13] [config] lr-decay-strategy: epoch+stalled
[2019-04-02 03:32:13] [config] lr-report: true
[2019-04-02 03:32:13] [config] lr-warmup: 16000
[2019-04-02 03:32:13] [config] lr-warmup-at-reload: false
[2019-04-02 03:32:13] [config] lr-warmup-cycle: false
[2019-04-02 03:32:13] [config] lr-warmup-start-rate: 0
[2019-04-02 03:32:13] [config] max-length: 160
[2019-04-02 03:32:13] [config] max-length-crop: false
[2019-04-02 03:32:13] [config] max-length-factor: 3
[2019-04-02 03:32:13] [config] maxi-batch: 1000
[2019-04-02 03:32:13] [config] maxi-batch-sort: trg
[2019-04-02 03:32:13] [config] mini-batch: 1000
[2019-04-02 03:32:13] [config] mini-batch-fit: true
[2019-04-02 03:32:13] [config] mini-batch-fit-step: 10
[2019-04-02 03:32:13] [config] mini-batch-overstuff: 1
[2019-04-02 03:32:13] [config] mini-batch-track-lr: false
[2019-04-02 03:32:13] [config] mini-batch-understuff: 1
[2019-04-02 03:32:13] [config] mini-batch-warmup: 0
[2019-04-02 03:32:13] [config] mini-batch-words: 0
[2019-04-02 03:32:13] [config] mini-batch-words-ref: 0
[2019-04-02 03:32:13] [config] model: model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz
[2019-04-02 03:32:13] [config] multi-loss-type: sum
[2019-04-02 03:32:13] [config] multi-node: false
[2019-04-02 03:32:13] [config] multi-node-overlap: true
[2019-04-02 03:32:13] [config] n-best: false
[2019-04-02 03:32:13] [config] no-nccl: true
[2019-04-02 03:32:13] [config] no-reload: false
[2019-04-02 03:32:13] [config] no-restore-corpus: true
[2019-04-02 03:32:13] [config] no-shuffle: false
[2019-04-02 03:32:13] [config] normalize: 0.6
[2019-04-02 03:32:13] [config] num-devices: 0
[2019-04-02 03:32:13] [config] optimizer: adam
[2019-04-02 03:32:13] [config] optimizer-delay: 4
[2019-04-02 03:32:13] [config] optimizer-params:
[2019-04-02 03:32:13] [config]   - 0.9
[2019-04-02 03:32:13] [config]   - 0.98
[2019-04-02 03:32:13] [config]   - 1e-09
[2019-04-02 03:32:13] [config] overwrite: false
[2019-04-02 03:32:13] [config] pretrained-model: model/model.src1tgt0.docnew.enc_depth.test_base.npz.best-perplexity.npz
[2019-04-02 03:32:13] [config] quiet: false
[2019-04-02 03:32:13] [config] quiet-translation: true
[2019-04-02 03:32:13] [config] relative-paths: false
[2019-04-02 03:32:13] [config] right-left: false
[2019-04-02 03:32:13] [config] save-freq: 1000
[2019-04-02 03:32:13] [config] seed: 1111
[2019-04-02 03:32:13] [config] shuffle-in-ram: false
[2019-04-02 03:32:13] [config] skip: false
[2019-04-02 03:32:13] [config] sqlite: ""
[2019-04-02 03:32:13] [config] sqlite-drop: false
[2019-04-02 03:32:13] [config] sync-sgd: true
[2019-04-02 03:32:13] [config] tempdir: /tmp
[2019-04-02 03:32:13] [config] tied-embeddings: false
[2019-04-02 03:32:13] [config] tied-embeddings-all: true
[2019-04-02 03:32:13] [config] tied-embeddings-src: false
[2019-04-02 03:32:13] [config] train-sets:
[2019-04-02 03:32:13] [config]   - corp/europarl.cs-en.docs.train.en.bpe.src_prev
[2019-04-02 03:32:13] [config]   - corp/europarl.cs-en.docs.train.en.bpe.src
[2019-04-02 03:32:13] [config]   - corp/europarl.cs-en.docs.train.cz.bpe
[2019-04-02 03:32:13] [config] transformer-aan-activation: swish
[2019-04-02 03:32:13] [config] transformer-aan-depth: 2
[2019-04-02 03:32:13] [config] transformer-aan-nogate: false
[2019-04-02 03:32:13] [config] transformer-decoder-autoreg: self-attention
[2019-04-02 03:32:13] [config] transformer-dim-aan: 2048
[2019-04-02 03:32:13] [config] transformer-dim-ffn: 2048
[2019-04-02 03:32:13] [config] transformer-dropout: 0.1
[2019-04-02 03:32:13] [config] transformer-dropout-attention: 0
[2019-04-02 03:32:13] [config] transformer-dropout-ffn: 0
[2019-04-02 03:32:13] [config] transformer-ffn-activation: swish
[2019-04-02 03:32:13] [config] transformer-ffn-depth: 2
[2019-04-02 03:32:13] [config] transformer-guided-alignment-layer: last
[2019-04-02 03:32:13] [config] transformer-heads: 8
[2019-04-02 03:32:13] [config] transformer-no-projection: false
[2019-04-02 03:32:13] [config] transformer-postprocess: dan
[2019-04-02 03:32:13] [config] transformer-postprocess-emb: d
[2019-04-02 03:32:13] [config] transformer-preprocess: ""
[2019-04-02 03:32:13] [config] transformer-tied-layers:
[2019-04-02 03:32:13] [config]   []
[2019-04-02 03:32:13] [config] transformer-train-position-embeddings: false
[2019-04-02 03:32:13] [config] type: transformer-context
[2019-04-02 03:32:13] [config] ulr: false
[2019-04-02 03:32:13] [config] ulr-dim-emb: 0
[2019-04-02 03:32:13] [config] ulr-dropout: 0
[2019-04-02 03:32:13] [config] ulr-keys-vectors: ""
[2019-04-02 03:32:13] [config] ulr-query-vectors: ""
[2019-04-02 03:32:13] [config] ulr-softmax-temperature: 1
[2019-04-02 03:32:13] [config] ulr-trainable-transformation: false
[2019-04-02 03:32:13] [config] valid-freq: 5000
[2019-04-02 03:32:13] [config] valid-log: model/valid_trans.gate.log
[2019-04-02 03:32:13] [config] valid-max-length: 1000
[2019-04-02 03:32:13] [config] valid-metrics:
[2019-04-02 03:32:13] [config]   - cross-entropy
[2019-04-02 03:32:13] [config]   - perplexity
[2019-04-02 03:32:13] [config]   - translation
[2019-04-02 03:32:13] [config] valid-mini-batch: 16
[2019-04-02 03:32:13] [config] valid-script-path: ./val.sh
[2019-04-02 03:32:13] [config] valid-sets:
[2019-04-02 03:32:13] [config]   - corp/europarl.cs-en.docs.dev.en.bpe.src_prev
[2019-04-02 03:32:13] [config]   - corp/europarl.cs-en.docs.dev.en.bpe.src
[2019-04-02 03:32:13] [config]   - corp/europarl.cs-en.docs.dev.cz.bpe
[2019-04-02 03:32:13] [config] valid-translation-output: data/valid.bpe.en.output
[2019-04-02 03:32:13] [config] version: v1.7.8 b59f01a 2019-04-02 03:22:27 +0200
[2019-04-02 03:32:13] [config] vocabs:
[2019-04-02 03:32:13] [config]   - corp/vocab.encz.opensub.new.yml
[2019-04-02 03:32:13] [config]   - corp/vocab.encz.opensub.new.yml
[2019-04-02 03:32:13] [config]   - corp/vocab.encz.opensub.new.yml
[2019-04-02 03:32:13] [config] word-penalty: 0
[2019-04-02 03:32:13] [config] workspace: 7800
[2019-04-02 03:32:13] [config] Loaded model has been created with Marian v1.7.8 b59f01a 2019-04-02 03:22:27 +0200
[2019-04-02 03:32:13] Using synchronous training
[2019-04-02 03:32:13] [data] Loading vocabulary from JSON/Yaml file corp/vocab.encz.opensub.new.yml
[2019-04-02 03:32:14] [data] Setting vocabulary size for input 0 to 30000
[2019-04-02 03:32:14] [data] Loading vocabulary from JSON/Yaml file corp/vocab.encz.opensub.new.yml
[2019-04-02 03:32:14] [data] Setting vocabulary size for input 1 to 30000
[2019-04-02 03:32:14] [data] Loading vocabulary from JSON/Yaml file corp/vocab.encz.opensub.new.yml
[2019-04-02 03:32:14] [data] Setting vocabulary size for input 2 to 30000
[2019-04-02 03:32:14] Compiled without MPI support. Falling back to FakeMPIWrapper
[2019-04-02 03:32:14] [batching] Collecting statistics for batch fitting with step size 10
[2019-04-02 03:32:14] [memory] Extending reserved space to 7808 MB (device gpu0)
[2019-04-02 03:32:15] [comm] NCCL communicator overridden
[2019-04-02 03:32:15] [training] Using 1 GPUs
[2019-04-02 03:32:15] [memory] Reserving 311 MB, device gpu0
[2019-04-02 03:32:15] [gpu] 16-bit TensorCores enabled for float32 matrix operations
[2019-04-02 03:32:15] [memory] Reserving 311 MB, device gpu0
[2019-04-02 03:32:21] [batching] Done. Typical MB size is 10685 target words
[2019-04-02 03:32:21] [memory] Extending reserved space to 7808 MB (device gpu0)
[2019-04-02 03:32:21] [comm] NCCL communicator overridden
[2019-04-02 03:32:21] [training] Using 1 GPUs
[2019-04-02 03:32:21] Loading model from model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz.orig.npz
[2019-04-02 03:32:24] Loading Adam parameters from model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz.optimizer.npz
[2019-04-02 03:32:30] [memory] Reserving 622 MB, device gpu0
[2019-04-02 03:32:31] [training] Model reloaded from model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz
[2019-04-02 03:32:31] Training started
[2019-04-02 03:32:31] [data] Shuffling data
[2019-04-02 03:32:31] [data] Done reading 620637 sentences
[2019-04-02 03:32:33] [data] Done shuffling 620637 sentences to temp files
[2019-04-02 03:32:56] [training] Batches are processed as 1 process(es) x 1 devices/process
[2019-04-02 03:32:56] [memory] Reserving 311 MB, device gpu0
[2019-04-02 03:32:56] [memory] Reserving 311 MB, device gpu0
[2019-04-02 03:32:56] Loading model from model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz
[2019-04-02 03:32:59] [memory] Reserving 311 MB, device cpu0
[2019-04-02 03:32:59] [memory] Reserving 311 MB, device gpu0
[2019-04-02 03:32:59] [memory] Reserving 311 MB, device gpu0
[2019-04-02 03:35:12] Ep. 1 : Up. 1000 : Sen. 68,136 : Cost 87.48114014 : Time 178.04s : 11760.48 words/s : L.r. 6.2500e-06
[2019-04-02 03:35:12] Saving model weights and runtime parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz.orig.npz
[2019-04-02 03:35:17] Saving model weights and runtime parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.iter1000.npz
[2019-04-02 03:35:21] Saving model weights and runtime parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz
[2019-04-02 03:35:25] Saving Adam parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz.optimizer.npz
[2019-04-02 03:41:01] Ep. 1 : Up. 2000 : Sen. 233,053 : Cost 68.35231781 : Time 349.06s : 14398.97 words/s : L.r. 1.2500e-05
[2019-04-02 03:41:01] Saving model weights and runtime parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz.orig.npz
[2019-04-02 03:41:05] Saving model weights and runtime parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.iter2000.npz
[2019-04-02 03:41:09] Saving model weights and runtime parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz
[2019-04-02 03:41:14] Saving Adam parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz.optimizer.npz
[2019-04-02 03:46:57] Ep. 1 : Up. 3000 : Sen. 398,772 : Cost 66.19686127 : Time 355.69s : 14603.59 words/s : L.r. 1.8750e-05
[2019-04-02 03:46:57] Saving model weights and runtime parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz.orig.npz
[2019-04-02 03:47:06] Saving model weights and runtime parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.iter3000.npz
[2019-04-02 03:47:10] Saving model weights and runtime parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz
[2019-04-02 03:47:14] Saving Adam parameters to model/model.src1tgt0.docnew.enc_depth.pretrained.frozen2.fix_emb11.nogate.npz.optimizer.npz
