[2018-12-01 22:45:41] [marian] Marian v1.7.0 67124f8 2018-11-28 13:04:30 +0000
[2018-12-01 22:45:41] [marian] Running on prometheus.lingea.cz as process 18921 with command line:
[2018-12-01 22:45:41] [marian] /home/big_maggie/usr/marian_prometheus/marian_1.7.0/marian-dev/build/marian --model model/model.src0tgt0.trans.batch70.opt64.3.npz --type transformer --train-sets corp/europarl.cs-en.docs.train.en.bpe corp/europarl.cs-en.docs.train.cz.bpe --max-length 80 --vocabs corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml --mini-batch 70 --maxi-batch 1000 --early-stopping 15 --valid-freq 15000 --save-freq 15000 --disp-freq 1000 --valid-metrics cross-entropy perplexity translation --valid-sets corp/europarl.cs-en.docs.dev.en.bpe corp/europarl.cs-en.docs.dev.cz.bpe --valid-script-path ./val.sh --valid-translation-output data/valid32.bpe.en.output --quiet-translation --valid-mini-batch 16 --beam-size 6 --normalize 0.6 --log model/train_trans.log --valid-log model/valid_trans.log --enc-depth 6 --dec-depth 6 --transformer-heads 8 --transformer-postprocess-emb d --transformer-postprocess dan --transformer-dropout 0.1 --label-smoothing 0.1 --learn-rate 0.0003 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 --tied-embeddings-all --optimizer-delay 64 --devices 0 --sync-sgd --seed 1111 --exponential-smoothing
[2018-12-01 22:45:41] [config] after-batches: 0
[2018-12-01 22:45:41] [config] after-epochs: 0
[2018-12-01 22:45:41] [config] allow-unk: false
[2018-12-01 22:45:41] [config] beam-size: 6
[2018-12-01 22:45:41] [config] best-deep: false
[2018-12-01 22:45:41] [config] clip-gemm: 0
[2018-12-01 22:45:41] [config] clip-norm: 5
[2018-12-01 22:45:41] [config] cost-type: ce-mean
[2018-12-01 22:45:41] [config] cpu-threads: 0
[2018-12-01 22:45:41] [config] data-weighting-type: sentence
[2018-12-01 22:45:41] [config] dec-cell: gru
[2018-12-01 22:45:41] [config] dec-cell-base-depth: 2
[2018-12-01 22:45:41] [config] dec-cell-high-depth: 1
[2018-12-01 22:45:41] [config] dec-depth: 6
[2018-12-01 22:45:41] [config] devices:
[2018-12-01 22:45:41] [config]   - 0
[2018-12-01 22:45:41] [config] dim-emb: 512
[2018-12-01 22:45:41] [config] dim-rnn: 1024
[2018-12-01 22:45:41] [config] dim-vocabs:
[2018-12-01 22:45:41] [config]   - 0
[2018-12-01 22:45:41] [config]   - 0
[2018-12-01 22:45:41] [config] disp-first: 0
[2018-12-01 22:45:41] [config] disp-freq: 1000
[2018-12-01 22:45:41] [config] disp-label-counts: false
[2018-12-01 22:45:41] [config] dropout-rnn: 0
[2018-12-01 22:45:41] [config] dropout-src: 0
[2018-12-01 22:45:41] [config] dropout-trg: 0
[2018-12-01 22:45:41] [config] early-stopping: 15
[2018-12-01 22:45:41] [config] embedding-fix-src: false
[2018-12-01 22:45:41] [config] embedding-fix-trg: false
[2018-12-01 22:45:41] [config] embedding-normalization: false
[2018-12-01 22:45:41] [config] enc-cell: gru
[2018-12-01 22:45:41] [config] enc-cell-depth: 1
[2018-12-01 22:45:41] [config] enc-depth: 6
[2018-12-01 22:45:41] [config] enc-type: bidirectional
[2018-12-01 22:45:41] [config] exponential-smoothing: 0.0001
[2018-12-01 22:45:41] [config] grad-dropping-momentum: 0
[2018-12-01 22:45:41] [config] grad-dropping-rate: 0
[2018-12-01 22:45:41] [config] grad-dropping-warmup: 100
[2018-12-01 22:45:41] [config] guided-alignment: none
[2018-12-01 22:45:41] [config] guided-alignment-cost: mse
[2018-12-01 22:45:41] [config] guided-alignment-weight: 0.1
[2018-12-01 22:45:41] [config] ignore-model-config: false
[2018-12-01 22:45:41] [config] interpolate-env-vars: false
[2018-12-01 22:45:41] [config] keep-best: false
[2018-12-01 22:45:41] [config] label-smoothing: 0.1
[2018-12-01 22:45:41] [config] layer-normalization: false
[2018-12-01 22:45:41] [config] learn-rate: 0.0003
[2018-12-01 22:45:41] [config] log: model/train_trans.log
[2018-12-01 22:45:41] [config] log-level: info
[2018-12-01 22:45:41] [config] lr-decay: 0
[2018-12-01 22:45:41] [config] lr-decay-freq: 50000
[2018-12-01 22:45:41] [config] lr-decay-inv-sqrt: 16000
[2018-12-01 22:45:41] [config] lr-decay-repeat-warmup: false
[2018-12-01 22:45:41] [config] lr-decay-reset-optimizer: false
[2018-12-01 22:45:41] [config] lr-decay-start:
[2018-12-01 22:45:41] [config]   - 10
[2018-12-01 22:45:41] [config]   - 1
[2018-12-01 22:45:41] [config] lr-decay-strategy: epoch+stalled
[2018-12-01 22:45:41] [config] lr-report: true
[2018-12-01 22:45:41] [config] lr-warmup: 16000
[2018-12-01 22:45:41] [config] lr-warmup-at-reload: false
[2018-12-01 22:45:41] [config] lr-warmup-cycle: false
[2018-12-01 22:45:41] [config] lr-warmup-start-rate: 0
[2018-12-01 22:45:41] [config] max-length: 80
[2018-12-01 22:45:41] [config] max-length-crop: false
[2018-12-01 22:45:41] [config] max-length-factor: 3
[2018-12-01 22:45:41] [config] maxi-batch: 1000
[2018-12-01 22:45:41] [config] maxi-batch-sort: trg
[2018-12-01 22:45:41] [config] mini-batch: 70
[2018-12-01 22:45:41] [config] mini-batch-fit: false
[2018-12-01 22:45:41] [config] mini-batch-fit-step: 10
[2018-12-01 22:45:41] [config] mini-batch-words: 0
[2018-12-01 22:45:41] [config] model: model/model.src0tgt0.trans.batch70.opt64.3.npz
[2018-12-01 22:45:41] [config] multi-node: false
[2018-12-01 22:45:41] [config] multi-node-overlap: true
[2018-12-01 22:45:41] [config] n-best: false
[2018-12-01 22:45:41] [config] no-nccl: false
[2018-12-01 22:45:41] [config] no-reload: false
[2018-12-01 22:45:41] [config] no-restore-corpus: false
[2018-12-01 22:45:41] [config] no-shuffle: false
[2018-12-01 22:45:41] [config] normalize: 0.6
[2018-12-01 22:45:41] [config] optimizer: adam
[2018-12-01 22:45:41] [config] optimizer-delay: 64
[2018-12-01 22:45:41] [config] optimizer-params:
[2018-12-01 22:45:41] [config]   - 0.9
[2018-12-01 22:45:41] [config]   - 0.98
[2018-12-01 22:45:41] [config]   - 1e-09
[2018-12-01 22:45:41] [config] overwrite: false
[2018-12-01 22:45:41] [config] quiet: false
[2018-12-01 22:45:41] [config] quiet-translation: true
[2018-12-01 22:45:41] [config] relative-paths: false
[2018-12-01 22:45:41] [config] right-left: false
[2018-12-01 22:45:41] [config] save-freq: 15000
[2018-12-01 22:45:41] [config] seed: 1111
[2018-12-01 22:45:41] [config] sentencepiece-alphas:
[2018-12-01 22:45:41] [config]   []
[2018-12-01 22:45:41] [config] sentencepiece-max-lines: 10000000
[2018-12-01 22:45:41] [config] sentencepiece-options: ""
[2018-12-01 22:45:41] [config] shuffle-in-ram: false
[2018-12-01 22:45:41] [config] skip: false
[2018-12-01 22:45:41] [config] sqlite: ""
[2018-12-01 22:45:41] [config] sqlite-drop: false
[2018-12-01 22:45:41] [config] sync-sgd: true
[2018-12-01 22:45:41] [config] tempdir: /tmp
[2018-12-01 22:45:41] [config] tied-embeddings: false
[2018-12-01 22:45:41] [config] tied-embeddings-all: true
[2018-12-01 22:45:41] [config] tied-embeddings-src: false
[2018-12-01 22:45:41] [config] train-sets:
[2018-12-01 22:45:41] [config]   - corp/europarl.cs-en.docs.train.en.bpe
[2018-12-01 22:45:41] [config]   - corp/europarl.cs-en.docs.train.cz.bpe
[2018-12-01 22:45:41] [config] transformer-aan-activation: swish
[2018-12-01 22:45:41] [config] transformer-aan-depth: 2
[2018-12-01 22:45:41] [config] transformer-aan-nogate: false
[2018-12-01 22:45:41] [config] transformer-decoder-autoreg: self-attention
[2018-12-01 22:45:41] [config] transformer-dim-aan: 2048
[2018-12-01 22:45:41] [config] transformer-dim-ffn: 2048
[2018-12-01 22:45:41] [config] transformer-dropout: 0.1
[2018-12-01 22:45:41] [config] transformer-dropout-attention: 0
[2018-12-01 22:45:41] [config] transformer-dropout-ffn: 0
[2018-12-01 22:45:41] [config] transformer-ffn-activation: swish
[2018-12-01 22:45:41] [config] transformer-ffn-depth: 2
[2018-12-01 22:45:41] [config] transformer-guided-alignment-layer: last
[2018-12-01 22:45:41] [config] transformer-heads: 8
[2018-12-01 22:45:41] [config] transformer-no-projection: false
[2018-12-01 22:45:41] [config] transformer-postprocess: dan
[2018-12-01 22:45:41] [config] transformer-postprocess-emb: d
[2018-12-01 22:45:41] [config] transformer-preprocess: ""
[2018-12-01 22:45:41] [config] transformer-tied-layers:
[2018-12-01 22:45:41] [config]   []
[2018-12-01 22:45:41] [config] type: transformer
[2018-12-01 22:45:41] [config] ulr: false
[2018-12-01 22:45:41] [config] ulr-dim-emb: 0
[2018-12-01 22:45:41] [config] ulr-dropout: 0
[2018-12-01 22:45:41] [config] ulr-keys-vectors: ""
[2018-12-01 22:45:41] [config] ulr-query-vectors: ""
[2018-12-01 22:45:41] [config] ulr-softmax-temperature: 1
[2018-12-01 22:45:41] [config] ulr-trainable-transformation: false
[2018-12-01 22:45:41] [config] valid-freq: 15000
[2018-12-01 22:45:41] [config] valid-log: model/valid_trans.log
[2018-12-01 22:45:41] [config] valid-max-length: 1000
[2018-12-01 22:45:41] [config] valid-metrics:
[2018-12-01 22:45:41] [config]   - cross-entropy
[2018-12-01 22:45:41] [config]   - perplexity
[2018-12-01 22:45:41] [config]   - translation
[2018-12-01 22:45:41] [config] valid-mini-batch: 16
[2018-12-01 22:45:41] [config] valid-script-path: ./val.sh
[2018-12-01 22:45:41] [config] valid-sets:
[2018-12-01 22:45:41] [config]   - corp/europarl.cs-en.docs.dev.en.bpe
[2018-12-01 22:45:41] [config]   - corp/europarl.cs-en.docs.dev.cz.bpe
[2018-12-01 22:45:41] [config] valid-translation-output: data/valid32.bpe.en.output
[2018-12-01 22:45:41] [config] vocabs:
[2018-12-01 22:45:41] [config]   - corp/vocab.encs.europarl.yml
[2018-12-01 22:45:41] [config]   - corp/vocab.encs.europarl.yml
[2018-12-01 22:45:41] [config] word-penalty: 0
[2018-12-01 22:45:41] [config] workspace: 2048
[2018-12-01 22:45:41] [config] Model is being created with Marian v1.7.0 67124f8 2018-11-28 13:04:30 +0000
[2018-12-01 22:45:41] Using synchronous training
[2018-12-01 22:45:41] [data] Loading vocabulary from JSON/Yaml file corp/vocab.encs.europarl.yml
[2018-12-01 22:45:41] [data] Setting vocabulary size for input 0 to 32000
[2018-12-01 22:45:41] [data] Loading vocabulary from JSON/Yaml file corp/vocab.encs.europarl.yml
[2018-12-01 22:45:42] [data] Setting vocabulary size for input 1 to 32000
[2018-12-01 22:45:42] Compiled without MPI support. Falling back to FakeMPIWrapper
[2018-12-01 22:45:42] [memory] Extending reserved space to 2048 MB (device gpu0)
[2018-12-01 22:45:42] [comm] Using NCCL 2.3.7 for GPU communication
[2018-12-01 22:45:42] Training started
[2018-12-01 22:45:42] [data] Shuffling files
[2018-12-01 22:45:43] [data] Done reading 620637 sentences
[2018-12-01 22:45:45] [data] Done shuffling 620637 sentences to temp files
[2018-12-01 22:45:49] [memory] Reserving 230 MB, device gpu0
[2018-12-01 22:45:49] [memory] Reserving 230 MB, device gpu0
[2018-12-01 22:45:49] [memory] Reserving 230 MB, device gpu0
[2018-12-01 22:45:52] [memory] Reserving 461 MB, device gpu0
[2018-12-02 00:06:06] Ep. 1 : Up. 1000 : Sen. 70,000 : Cost 147.39466858 : Time 4824.02s : 428.61 words/s : L.r. 1.8750e-05
[2018-12-02 02:00:46] Ep. 1 : Up. 2000 : Sen. 140,000 : Cost 125.49166870 : Time 6880.65s : 300.74 words/s : L.r. 3.7500e-05
[2018-12-02 03:54:12] Ep. 1 : Up. 3000 : Sen. 210,000 : Cost 117.25371552 : Time 6805.41s : 303.18 words/s : L.r. 5.6250e-05
[2018-12-02 05:50:42] Ep. 1 : Up. 4000 : Sen. 280,000 : Cost 109.21723938 : Time 6990.07s : 296.10 words/s : L.r. 7.5000e-05
[2018-12-02 07:45:06] Ep. 1 : Up. 5000 : Sen. 350,000 : Cost 102.07215118 : Time 6863.91s : 301.44 words/s : L.r. 9.3750e-05
[2018-12-02 09:44:43] Ep. 1 : Up. 6000 : Sen. 420,000 : Cost 96.08455658 : Time 7176.97s : 289.11 words/s : L.r. 1.1250e-04
[2018-12-02 11:42:34] Ep. 1 : Up. 7000 : Sen. 490,000 : Cost 90.04822540 : Time 7071.07s : 292.06 words/s : L.r. 1.3125e-04
[2018-12-02 12:48:13] Ep. 1 : Up. 8000 : Sen. 560,000 : Cost 84.65728760 : Time 3939.31s : 525.51 words/s : L.r. 1.5000e-04
[2018-12-02 13:20:33] Seen 609664 samples
[2018-12-02 13:20:33] Starting epoch 2
[2018-12-02 13:20:33] [data] Shuffling files
[2018-12-02 13:20:33] [data] Done reading 620637 sentences
[2018-12-02 13:20:35] [data] Done shuffling 620637 sentences to temp files
[2018-12-02 13:33:57] Ep. 2 : Up. 9000 : Sen. 20,300 : Cost 78.17609406 : Time 2743.65s : 755.93 words/s : L.r. 1.6875e-04
[2018-12-02 14:17:27] Ep. 2 : Up. 10000 : Sen. 90,300 : Cost 70.57009888 : Time 2610.38s : 783.73 words/s : L.r. 1.8750e-04
[2018-12-02 15:03:14] Ep. 2 : Up. 11000 : Sen. 160,300 : Cost 66.72076416 : Time 2746.93s : 761.44 words/s : L.r. 2.0625e-04
[2018-12-02 15:51:42] Ep. 2 : Up. 12000 : Sen. 230,300 : Cost 62.32627106 : Time 2907.66s : 713.84 words/s : L.r. 2.2500e-04
[2018-12-02 16:41:22] Ep. 2 : Up. 13000 : Sen. 300,300 : Cost 58.98201752 : Time 2980.00s : 689.54 words/s : L.r. 2.4375e-04
[2018-12-02 17:31:16] Ep. 2 : Up. 14000 : Sen. 370,300 : Cost 57.21466827 : Time 2994.12s : 688.19 words/s : L.r. 2.6250e-04
[2018-12-02 18:21:18] Ep. 2 : Up. 15000 : Sen. 440,300 : Cost 56.51124573 : Time 3001.83s : 694.13 words/s : L.r. 2.8125e-04
[2018-12-02 18:21:18] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.orig.npz
[2018-12-02 18:21:24] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.iter15000.npz
[2018-12-02 18:21:28] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz
[2018-12-02 18:21:33] Saving Adam parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.optimizer.npz
[2018-12-02 18:22:18] [valid] Ep. 2 : Up. 15000 : cross-entropy : 74.643 : new best
[2018-12-02 18:22:37] [valid] Ep. 2 : Up. 15000 : perplexity : 11.148 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2018-12-02 18:31:37] [valid] Ep. 2 : Up. 15000 : translation : 19.53 : new best
[2018-12-02 19:20:47] Ep. 2 : Up. 16000 : Sen. 510,300 : Cost 54.96305847 : Time 3569.15s : 578.71 words/s : L.r. 3.0000e-04
[2018-12-02 20:07:58] Ep. 2 : Up. 17000 : Sen. 580,264 : Cost 53.94162369 : Time 2830.51s : 728.23 words/s : L.r. 2.9104e-04
[2018-12-02 20:27:42] Seen 609664 samples
[2018-12-02 20:27:42] Starting epoch 3
[2018-12-02 20:27:42] [data] Shuffling files
[2018-12-02 20:27:43] [data] Done reading 620637 sentences
[2018-12-02 20:27:46] [data] Done shuffling 620637 sentences to temp files
[2018-12-02 20:55:07] Ep. 3 : Up. 18000 : Sen. 40,600 : Cost 52.89957047 : Time 2829.20s : 736.97 words/s : L.r. 2.8284e-04
[2018-12-02 21:41:47] Ep. 3 : Up. 19000 : Sen. 110,600 : Cost 51.07128525 : Time 2800.40s : 732.75 words/s : L.r. 2.7530e-04
[2018-12-02 22:28:44] Ep. 3 : Up. 20000 : Sen. 180,600 : Cost 51.47020721 : Time 2816.56s : 741.34 words/s : L.r. 2.6833e-04
[2018-12-02 23:16:23] Ep. 3 : Up. 21000 : Sen. 250,600 : Cost 50.09307861 : Time 2858.84s : 720.45 words/s : L.r. 2.6186e-04
[2018-12-03 00:03:24] Ep. 3 : Up. 22000 : Sen. 320,600 : Cost 50.53148651 : Time 2821.81s : 743.48 words/s : L.r. 2.5584e-04
[2018-12-03 00:49:36] Ep. 3 : Up. 23000 : Sen. 390,600 : Cost 48.18317032 : Time 2771.85s : 731.40 words/s : L.r. 2.5022e-04
[2018-12-03 01:36:35] Ep. 3 : Up. 24000 : Sen. 460,600 : Cost 48.93758774 : Time 2818.79s : 737.04 words/s : L.r. 2.4495e-04
[2018-12-03 02:22:25] Ep. 3 : Up. 25000 : Sen. 530,600 : Cost 47.92556763 : Time 2750.01s : 745.40 words/s : L.r. 2.4000e-04
[2018-12-03 03:08:10] Ep. 3 : Up. 26000 : Sen. 600,564 : Cost 48.27397919 : Time 2745.38s : 755.63 words/s : L.r. 2.3534e-04
[2018-12-03 03:14:07] Seen 609664 samples
[2018-12-03 03:14:07] Starting epoch 4
[2018-12-03 03:14:07] [data] Shuffling files
[2018-12-03 03:14:07] [data] Done reading 620637 sentences
[2018-12-03 03:14:09] [data] Done shuffling 620637 sentences to temp files
[2018-12-03 03:53:02] Ep. 4 : Up. 27000 : Sen. 60,900 : Cost 46.54913330 : Time 2691.33s : 762.13 words/s : L.r. 2.3094e-04
[2018-12-03 04:38:39] Ep. 4 : Up. 28000 : Sen. 130,900 : Cost 47.13489151 : Time 2737.10s : 760.80 words/s : L.r. 2.2678e-04
[2018-12-03 05:24:11] Ep. 4 : Up. 29000 : Sen. 200,900 : Cost 47.10586166 : Time 2732.60s : 762.91 words/s : L.r. 2.2283e-04
[2018-12-03 06:09:45] Ep. 4 : Up. 30000 : Sen. 270,900 : Cost 46.33181000 : Time 2733.08s : 754.60 words/s : L.r. 2.1909e-04
[2018-12-03 06:09:45] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.orig.npz
[2018-12-03 06:09:50] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.iter30000.npz
[2018-12-03 06:09:54] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz
[2018-12-03 06:09:58] Saving Adam parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.optimizer.npz
[2018-12-03 06:10:25] [valid] Ep. 4 : Up. 30000 : cross-entropy : 56.4161 : new best
[2018-12-03 06:10:43] [valid] Ep. 4 : Up. 30000 : perplexity : 6.18704 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2018-12-03 06:18:31] [valid] Ep. 4 : Up. 30000 : translation : 25.75 : new best
[2018-12-03 07:04:12] Ep. 4 : Up. 31000 : Sen. 340,900 : Cost 46.48752975 : Time 3267.47s : 636.56 words/s : L.r. 2.1553e-04
[2018-12-03 07:49:38] Ep. 4 : Up. 32000 : Sen. 410,900 : Cost 45.60810089 : Time 2725.58s : 750.42 words/s : L.r. 2.1213e-04
[2018-12-03 08:35:08] Ep. 4 : Up. 33000 : Sen. 480,900 : Cost 46.32806015 : Time 2730.72s : 763.26 words/s : L.r. 2.0889e-04
[2018-12-03 09:20:38] Ep. 4 : Up. 34000 : Sen. 550,900 : Cost 45.81431961 : Time 2729.94s : 760.25 words/s : L.r. 2.0580e-04
[2018-12-03 09:58:47] Seen 609664 samples
[2018-12-03 09:58:47] Starting epoch 5
[2018-12-03 09:58:47] [data] Shuffling files
[2018-12-03 09:58:48] [data] Done reading 620637 sentences
[2018-12-03 09:58:50] [data] Done shuffling 620637 sentences to temp files
[2018-12-03 10:06:15] Ep. 5 : Up. 35000 : Sen. 11,200 : Cost 45.45391464 : Time 2737.14s : 754.78 words/s : L.r. 2.0284e-04
[2018-12-03 10:51:56] Ep. 5 : Up. 36000 : Sen. 81,200 : Cost 44.90231705 : Time 2740.92s : 758.81 words/s : L.r. 2.0000e-04
[2018-12-03 11:37:31] Ep. 5 : Up. 37000 : Sen. 151,200 : Cost 43.91592407 : Time 2734.43s : 744.04 words/s : L.r. 1.9728e-04
[2018-12-03 12:23:04] Ep. 5 : Up. 38000 : Sen. 221,200 : Cost 45.14306641 : Time 2733.50s : 765.51 words/s : L.r. 1.9467e-04
[2018-12-03 13:08:38] Ep. 5 : Up. 39000 : Sen. 291,200 : Cost 44.42407608 : Time 2733.46s : 755.09 words/s : L.r. 1.9215e-04
[2018-12-03 13:54:08] Ep. 5 : Up. 40000 : Sen. 361,200 : Cost 43.99221039 : Time 2730.81s : 749.80 words/s : L.r. 1.8974e-04
[2018-12-03 14:39:33] Ep. 5 : Up. 41000 : Sen. 431,200 : Cost 44.64064789 : Time 2724.06s : 762.41 words/s : L.r. 1.8741e-04
[2018-12-03 15:23:51] Ep. 5 : Up. 42000 : Sen. 501,200 : Cost 44.54740524 : Time 2658.18s : 781.23 words/s : L.r. 1.8516e-04
[2018-12-03 16:09:23] Ep. 5 : Up. 43000 : Sen. 571,200 : Cost 43.84214401 : Time 2732.52s : 749.77 words/s : L.r. 1.8300e-04
[2018-12-03 16:34:27] Seen 609664 samples
[2018-12-03 16:34:27] Starting epoch 6
[2018-12-03 16:34:27] [data] Shuffling files
[2018-12-03 16:34:28] [data] Done reading 620637 sentences
[2018-12-03 16:34:31] [data] Done shuffling 620637 sentences to temp files
[2018-12-03 16:55:04] Ep. 6 : Up. 44000 : Sen. 31,500 : Cost 43.98139572 : Time 2740.51s : 757.65 words/s : L.r. 1.8091e-04
[2018-12-03 17:40:30] Ep. 6 : Up. 45000 : Sen. 101,500 : Cost 43.91005707 : Time 2726.63s : 769.57 words/s : L.r. 1.7889e-04
[2018-12-03 17:40:30] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.orig.npz
[2018-12-03 17:40:36] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.iter45000.npz
[2018-12-03 17:40:40] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz
[2018-12-03 17:40:46] Saving Adam parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.optimizer.npz
[2018-12-03 17:41:13] [valid] Ep. 6 : Up. 45000 : cross-entropy : 52.0455 : new best
[2018-12-03 17:41:31] [valid] Ep. 6 : Up. 45000 : perplexity : 5.37237 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2018-12-03 17:49:21] [valid] Ep. 6 : Up. 45000 : translation : 27.13 : new best
[2018-12-03 18:34:47] Ep. 6 : Up. 46000 : Sen. 171,500 : Cost 42.34837341 : Time 3256.38s : 620.60 words/s : L.r. 1.7693e-04
[2018-12-03 19:20:16] Ep. 6 : Up. 47000 : Sen. 241,500 : Cost 43.69676971 : Time 2729.07s : 763.31 words/s : L.r. 1.7504e-04
[2018-12-03 20:05:55] Ep. 6 : Up. 48000 : Sen. 311,500 : Cost 43.44575882 : Time 2739.06s : 755.12 words/s : L.r. 1.7321e-04
[2018-12-03 20:51:24] Ep. 6 : Up. 49000 : Sen. 381,500 : Cost 43.85242081 : Time 2729.35s : 764.35 words/s : L.r. 1.7143e-04
[2018-12-03 21:36:51] Ep. 6 : Up. 50000 : Sen. 451,500 : Cost 43.04981995 : Time 2726.65s : 753.78 words/s : L.r. 1.6971e-04
[2018-12-03 22:22:20] Ep. 6 : Up. 51000 : Sen. 521,500 : Cost 43.25861740 : Time 2729.47s : 756.47 words/s : L.r. 1.6803e-04
[2018-12-03 23:07:46] Ep. 6 : Up. 52000 : Sen. 591,464 : Cost 43.63819885 : Time 2725.54s : 763.70 words/s : L.r. 1.6641e-04
[2018-12-03 23:19:40] Seen 609664 samples
[2018-12-03 23:19:40] Starting epoch 7
[2018-12-03 23:19:40] [data] Shuffling files
[2018-12-03 23:19:40] [data] Done reading 620637 sentences
[2018-12-03 23:19:43] [data] Done shuffling 620637 sentences to temp files
[2018-12-03 23:53:31] Ep. 7 : Up. 53000 : Sen. 51,800 : Cost 43.16930389 : Time 2744.60s : 765.51 words/s : L.r. 1.6483e-04
[2018-12-04 00:38:53] Ep. 7 : Up. 54000 : Sen. 121,800 : Cost 41.28287125 : Time 2722.52s : 740.68 words/s : L.r. 1.6330e-04
[2018-12-04 01:24:23] Ep. 7 : Up. 55000 : Sen. 191,800 : Cost 42.62599564 : Time 2730.37s : 757.56 words/s : L.r. 1.6181e-04
[2018-12-04 02:10:02] Ep. 7 : Up. 56000 : Sen. 261,800 : Cost 43.07262802 : Time 2738.67s : 765.18 words/s : L.r. 1.6036e-04
[2018-12-04 02:54:15] Ep. 7 : Up. 57000 : Sen. 331,800 : Cost 42.10185242 : Time 2653.39s : 770.11 words/s : L.r. 1.5894e-04
[2018-12-04 03:39:29] Ep. 7 : Up. 58000 : Sen. 401,800 : Cost 43.00391006 : Time 2713.91s : 770.57 words/s : L.r. 1.5757e-04
[2018-12-04 04:24:56] Ep. 7 : Up. 59000 : Sen. 471,800 : Cost 42.36991119 : Time 2726.37s : 755.52 words/s : L.r. 1.5623e-04
[2018-12-04 05:10:27] Ep. 7 : Up. 60000 : Sen. 541,800 : Cost 42.82112885 : Time 2731.19s : 761.77 words/s : L.r. 1.5492e-04
[2018-12-04 05:10:27] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.orig.npz
[2018-12-04 05:10:32] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.iter60000.npz
[2018-12-04 05:10:37] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz
[2018-12-04 05:10:43] Saving Adam parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.optimizer.npz
[2018-12-04 05:11:10] [valid] Ep. 7 : Up. 60000 : cross-entropy : 50.2127 : new best
[2018-12-04 05:11:28] [valid] Ep. 7 : Up. 60000 : perplexity : 5.06353 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2018-12-04 05:19:26] [valid] Ep. 7 : Up. 60000 : translation : 27.79 : new best
[2018-12-04 06:03:45] Seen 609664 samples
[2018-12-04 06:03:45] Starting epoch 8
[2018-12-04 06:03:45] [data] Shuffling files
[2018-12-04 06:03:46] [data] Done reading 620637 sentences
[2018-12-04 06:03:48] [data] Done shuffling 620637 sentences to temp files
[2018-12-04 06:05:14] Ep. 8 : Up. 61000 : Sen. 2,100 : Cost 42.51935577 : Time 3287.56s : 629.11 words/s : L.r. 1.5364e-04
[2018-12-04 06:50:52] Ep. 8 : Up. 62000 : Sen. 72,100 : Cost 41.33858871 : Time 2737.74s : 752.69 words/s : L.r. 1.5240e-04
[2018-12-04 07:36:27] Ep. 8 : Up. 63000 : Sen. 142,100 : Cost 42.01847839 : Time 2734.91s : 760.70 words/s : L.r. 1.5119e-04
[2018-12-04 08:22:09] Ep. 8 : Up. 64000 : Sen. 212,100 : Cost 41.94841385 : Time 2741.45s : 755.00 words/s : L.r. 1.5000e-04
[2018-12-04 09:07:39] Ep. 8 : Up. 65000 : Sen. 282,100 : Cost 42.10918808 : Time 2730.44s : 760.41 words/s : L.r. 1.4884e-04
[2018-12-04 09:52:56] Ep. 8 : Up. 66000 : Sen. 352,100 : Cost 42.02661514 : Time 2716.70s : 763.04 words/s : L.r. 1.4771e-04
[2018-12-04 10:37:48] Ep. 8 : Up. 67000 : Sen. 422,100 : Cost 41.55242538 : Time 2692.52s : 761.67 words/s : L.r. 1.4660e-04
[2018-12-04 11:23:06] Ep. 8 : Up. 68000 : Sen. 492,100 : Cost 42.11158752 : Time 2717.78s : 763.50 words/s : L.r. 1.4552e-04
[2018-12-04 12:08:26] Ep. 8 : Up. 69000 : Sen. 562,100 : Cost 41.90442657 : Time 2719.53s : 758.79 words/s : L.r. 1.4446e-04
[2018-12-04 12:39:21] Seen 609664 samples
[2018-12-04 12:39:21] Starting epoch 9
[2018-12-04 12:39:21] [data] Shuffling files
[2018-12-04 12:39:22] [data] Done reading 620637 sentences
[2018-12-04 12:39:25] [data] Done shuffling 620637 sentences to temp files
[2018-12-04 12:54:06] Ep. 9 : Up. 70000 : Sen. 22,400 : Cost 41.43616104 : Time 2740.01s : 750.43 words/s : L.r. 1.4343e-04
[2018-12-04 13:39:46] Ep. 9 : Up. 71000 : Sen. 92,400 : Cost 41.07157898 : Time 2740.15s : 755.12 words/s : L.r. 1.4241e-04
[2018-12-04 14:24:22] Ep. 9 : Up. 72000 : Sen. 162,400 : Cost 41.12710571 : Time 2676.39s : 767.75 words/s : L.r. 1.4142e-04
[2018-12-04 15:09:57] Ep. 9 : Up. 73000 : Sen. 232,400 : Cost 41.77808762 : Time 2735.07s : 764.74 words/s : L.r. 1.4045e-04
[2018-12-04 15:55:22] Ep. 9 : Up. 74000 : Sen. 302,400 : Cost 41.50953293 : Time 2725.01s : 760.81 words/s : L.r. 1.3950e-04
[2018-12-04 16:40:59] Ep. 9 : Up. 75000 : Sen. 372,400 : Cost 41.38324738 : Time 2736.53s : 755.51 words/s : L.r. 1.3856e-04
[2018-12-04 16:40:59] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.orig.npz
[2018-12-04 16:41:06] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.iter75000.npz
[2018-12-04 16:41:12] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz
[2018-12-04 16:41:19] Saving Adam parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.optimizer.npz
[2018-12-04 16:41:47] [valid] Ep. 9 : Up. 75000 : cross-entropy : 49.1824 : new best
[2018-12-04 16:42:04] [valid] Ep. 9 : Up. 75000 : perplexity : 4.89778 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2018-12-04 16:49:28] [valid] Ep. 9 : Up. 75000 : translation : 28.18 : new best
[2018-12-04 17:34:57] Ep. 9 : Up. 76000 : Sen. 442,400 : Cost 40.99772644 : Time 3238.29s : 632.16 words/s : L.r. 1.3765e-04
[2018-12-04 18:20:36] Ep. 9 : Up. 77000 : Sen. 512,400 : Cost 42.11766815 : Time 2738.40s : 766.24 words/s : L.r. 1.3675e-04
[2018-12-04 19:06:11] Ep. 9 : Up. 78000 : Sen. 582,364 : Cost 41.20580673 : Time 2735.87s : 751.11 words/s : L.r. 1.3587e-04
[2018-12-04 19:23:58] Seen 609664 samples
[2018-12-04 19:23:58] Starting epoch 10
[2018-12-04 19:23:58] [data] Shuffling files
[2018-12-04 19:23:58] [data] Done reading 620637 sentences
[2018-12-04 19:24:01] [data] Done shuffling 620637 sentences to temp files
[2018-12-04 19:52:04] Ep. 10 : Up. 79000 : Sen. 42,700 : Cost 41.54970932 : Time 2752.39s : 763.99 words/s : L.r. 1.3501e-04
[2018-12-04 20:37:40] Ep. 10 : Up. 80000 : Sen. 112,700 : Cost 39.85292053 : Time 2736.38s : 741.50 words/s : L.r. 1.3416e-04
[2018-12-04 21:23:24] Ep. 10 : Up. 81000 : Sen. 182,700 : Cost 40.69256973 : Time 2743.94s : 750.83 words/s : L.r. 1.3333e-04
[2018-12-04 22:09:01] Ep. 10 : Up. 82000 : Sen. 252,700 : Cost 41.21447372 : Time 2736.70s : 761.17 words/s : L.r. 1.3252e-04
[2018-12-04 22:54:34] Ep. 10 : Up. 83000 : Sen. 322,700 : Cost 40.68775558 : Time 2733.39s : 752.07 words/s : L.r. 1.3172e-04
[2018-12-04 23:40:18] Ep. 10 : Up. 84000 : Sen. 392,700 : Cost 41.76458740 : Time 2743.32s : 766.27 words/s : L.r. 1.3093e-04
[2018-12-05 00:25:42] Ep. 10 : Up. 85000 : Sen. 462,700 : Cost 40.25625229 : Time 2724.07s : 744.96 words/s : L.r. 1.3016e-04
[2018-12-05 01:11:32] Ep. 10 : Up. 86000 : Sen. 532,700 : Cost 41.57442474 : Time 2750.01s : 760.89 words/s : L.r. 1.2940e-04
[2018-12-05 01:57:16] Ep. 10 : Up. 87000 : Sen. 602,700 : Cost 41.06576157 : Time 2744.33s : 753.66 words/s : L.r. 1.2865e-04
[2018-12-05 02:01:01] Seen 609664 samples
[2018-12-05 02:01:01] Starting epoch 11
[2018-12-05 02:01:01] [data] Shuffling files
[2018-12-05 02:01:01] [data] Done reading 620637 sentences
[2018-12-05 02:01:04] [data] Done shuffling 620637 sentences to temp files
[2018-12-05 02:41:53] Ep. 11 : Up. 88000 : Sen. 63,000 : Cost 40.33812714 : Time 2677.55s : 772.96 words/s : L.r. 1.2792e-04
[2018-12-05 03:27:31] Ep. 11 : Up. 89000 : Sen. 133,000 : Cost 40.14518738 : Time 2737.97s : 753.19 words/s : L.r. 1.2720e-04
[2018-12-05 04:13:10] Ep. 11 : Up. 90000 : Sen. 203,000 : Cost 40.20320892 : Time 2738.52s : 749.05 words/s : L.r. 1.2649e-04
[2018-12-05 04:13:10] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.orig.npz
[2018-12-05 04:13:15] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.iter90000.npz
[2018-12-05 04:13:19] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz
[2018-12-05 04:13:25] Saving Adam parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.optimizer.npz
[2018-12-05 04:13:53] [valid] Ep. 11 : Up. 90000 : cross-entropy : 48.2129 : new best
[2018-12-05 04:14:10] [valid] Ep. 11 : Up. 90000 : perplexity : 4.74676 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2018-12-05 04:21:36] [valid] Ep. 11 : Up. 90000 : translation : 28.55 : new best
[2018-12-05 05:07:23] Ep. 11 : Up. 91000 : Sen. 273,000 : Cost 40.85124969 : Time 3253.46s : 639.92 words/s : L.r. 1.2579e-04
[2018-12-05 05:52:55] Ep. 11 : Up. 92000 : Sen. 343,000 : Cost 40.59974670 : Time 2731.39s : 756.61 words/s : L.r. 1.2511e-04
[2018-12-05 06:37:10] Ep. 11 : Up. 93000 : Sen. 413,000 : Cost 40.89728546 : Time 2654.95s : 782.41 words/s : L.r. 1.2443e-04
[2018-12-05 07:21:32] Ep. 11 : Up. 94000 : Sen. 483,000 : Cost 40.64241028 : Time 2662.07s : 777.67 words/s : L.r. 1.2377e-04
[2018-12-05 08:05:59] Ep. 11 : Up. 95000 : Sen. 553,000 : Cost 40.47361755 : Time 2666.99s : 771.54 words/s : L.r. 1.2312e-04
[2018-12-05 08:41:55] Seen 609664 samples
[2018-12-05 08:41:55] Starting epoch 12
[2018-12-05 08:41:55] [data] Shuffling files
[2018-12-05 08:41:56] [data] Done reading 620637 sentences
[2018-12-05 08:41:58] [data] Done shuffling 620637 sentences to temp files
[2018-12-05 08:50:25] Ep. 12 : Up. 96000 : Sen. 13,300 : Cost 40.69244003 : Time 2665.68s : 778.49 words/s : L.r. 1.2247e-04
[2018-12-05 09:34:30] Ep. 12 : Up. 97000 : Sen. 83,300 : Cost 40.22360992 : Time 2645.54s : 787.40 words/s : L.r. 1.2184e-04
[2018-12-05 10:18:22] Ep. 12 : Up. 98000 : Sen. 153,300 : Cost 39.60274887 : Time 2631.73s : 777.64 words/s : L.r. 1.2122e-04
[2018-12-05 11:02:28] Ep. 12 : Up. 99000 : Sen. 223,300 : Cost 40.45940781 : Time 2645.64s : 787.76 words/s : L.r. 1.2060e-04
[2018-12-05 11:46:39] Ep. 12 : Up. 100000 : Sen. 293,300 : Cost 40.48349380 : Time 2651.25s : 784.76 words/s : L.r. 1.2000e-04
[2018-12-05 12:30:51] Ep. 12 : Up. 101000 : Sen. 363,300 : Cost 39.69393158 : Time 2652.46s : 768.35 words/s : L.r. 1.1940e-04
[2018-12-05 13:14:44] Ep. 12 : Up. 102000 : Sen. 433,300 : Cost 40.83205795 : Time 2632.72s : 795.65 words/s : L.r. 1.1882e-04
[2018-12-05 13:57:47] Ep. 12 : Up. 103000 : Sen. 503,300 : Cost 40.22284698 : Time 2582.85s : 797.25 words/s : L.r. 1.1824e-04
[2018-12-05 14:41:56] Ep. 12 : Up. 104000 : Sen. 573,300 : Cost 40.22087479 : Time 2649.43s : 776.52 words/s : L.r. 1.1767e-04
[2018-12-05 15:04:54] Seen 609664 samples
[2018-12-05 15:04:54] Starting epoch 13
[2018-12-05 15:04:54] [data] Shuffling files
[2018-12-05 15:04:54] [data] Done reading 620637 sentences
[2018-12-05 15:04:56] [data] Done shuffling 620637 sentences to temp files
[2018-12-05 15:26:11] Ep. 13 : Up. 105000 : Sen. 33,600 : Cost 39.56413651 : Time 2655.24s : 771.24 words/s : L.r. 1.1711e-04
[2018-12-05 15:26:11] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.orig.npz
[2018-12-05 15:26:16] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.iter105000.npz
[2018-12-05 15:26:20] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz
[2018-12-05 15:26:25] Saving Adam parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.optimizer.npz
[2018-12-05 15:26:51] [valid] Ep. 13 : Up. 105000 : cross-entropy : 47.5496 : new best
[2018-12-05 15:27:08] [valid] Ep. 13 : Up. 105000 : perplexity : 4.64613 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2018-12-05 15:34:06] [valid] Ep. 13 : Up. 105000 : translation : 28.71 : new best
[2018-12-05 16:18:32] Ep. 13 : Up. 106000 : Sen. 103,600 : Cost 40.89307404 : Time 3140.27s : 677.39 words/s : L.r. 1.1655e-04
[2018-12-05 17:02:38] Ep. 13 : Up. 107000 : Sen. 173,600 : Cost 39.44244766 : Time 2646.45s : 775.29 words/s : L.r. 1.1601e-04
[2018-12-05 17:46:46] Ep. 13 : Up. 108000 : Sen. 243,600 : Cost 39.38462448 : Time 2647.58s : 773.18 words/s : L.r. 1.1547e-04
[2018-12-05 18:31:07] Ep. 13 : Up. 109000 : Sen. 313,600 : Cost 40.70206451 : Time 2660.96s : 791.29 words/s : L.r. 1.1494e-04
[2018-12-05 19:15:10] Ep. 13 : Up. 110000 : Sen. 383,600 : Cost 38.65252686 : Time 2643.38s : 757.06 words/s : L.r. 1.1442e-04
[2018-12-05 19:59:12] Ep. 13 : Up. 111000 : Sen. 453,600 : Cost 40.89899063 : Time 2641.64s : 797.97 words/s : L.r. 1.1390e-04
[2018-12-05 20:43:21] Ep. 13 : Up. 112000 : Sen. 523,600 : Cost 39.92785645 : Time 2649.28s : 777.53 words/s : L.r. 1.1339e-04
[2018-12-05 21:27:34] Ep. 13 : Up. 113000 : Sen. 593,600 : Cost 40.67241287 : Time 2652.66s : 787.85 words/s : L.r. 1.1289e-04
[2018-12-05 21:37:41] Seen 609664 samples
[2018-12-05 21:37:41] Starting epoch 14
[2018-12-05 21:37:41] [data] Shuffling files
[2018-12-05 21:37:42] [data] Done reading 620637 sentences
[2018-12-05 21:37:43] [data] Done shuffling 620637 sentences to temp files
[2018-12-05 22:11:43] Ep. 14 : Up. 114000 : Sen. 53,900 : Cost 39.11325073 : Time 2649.34s : 773.83 words/s : L.r. 1.1239e-04
[2018-12-05 22:56:00] Ep. 14 : Up. 115000 : Sen. 123,900 : Cost 39.52338028 : Time 2656.69s : 780.03 words/s : L.r. 1.1190e-04
[2018-12-05 23:40:14] Ep. 14 : Up. 116000 : Sen. 193,900 : Cost 39.85638046 : Time 2653.81s : 785.46 words/s : L.r. 1.1142e-04
[2018-12-06 00:24:24] Ep. 14 : Up. 117000 : Sen. 263,900 : Cost 39.57940674 : Time 2649.95s : 778.32 words/s : L.r. 1.1094e-04
[2018-12-06 01:07:02] Ep. 14 : Up. 118000 : Sen. 333,900 : Cost 39.58023834 : Time 2557.75s : 805.79 words/s : L.r. 1.1047e-04
[2018-12-06 01:50:53] Ep. 14 : Up. 119000 : Sen. 403,900 : Cost 39.67093658 : Time 2631.07s : 784.64 words/s : L.r. 1.1000e-04
[2018-12-06 02:34:53] Ep. 14 : Up. 120000 : Sen. 473,900 : Cost 39.95714188 : Time 2640.05s : 783.49 words/s : L.r. 1.0954e-04
[2018-12-06 02:34:53] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.orig.npz
[2018-12-06 02:34:57] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.iter120000.npz
[2018-12-06 02:35:01] Saving model weights and runtime parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz
[2018-12-06 02:35:06] Saving Adam parameters to model/model.src0tgt0.trans.batch70.opt64.3.npz.optimizer.npz
[2018-12-06 02:35:31] [valid] Ep. 14 : Up. 120000 : cross-entropy : 47.1097 : new best
[2018-12-06 02:35:49] [valid] Ep. 14 : Up. 120000 : perplexity : 4.58057 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2018-12-06 02:42:48] [valid] Ep. 14 : Up. 120000 : translation : 29.01 : new best
[2018-12-06 03:26:55] Ep. 14 : Up. 121000 : Sen. 543,900 : Cost 39.59991837 : Time 3122.23s : 658.82 words/s : L.r. 1.0909e-04
[2018-12-06 04:08:26] Seen 609664 samples
[2018-12-06 04:08:26] Starting epoch 15
[2018-12-06 04:08:26] [data] Shuffling files
[2018-12-06 04:08:26] [data] Done reading 620637 sentences
[2018-12-06 04:08:28] [data] Done shuffling 620637 sentences to temp files
[2018-12-06 04:11:11] Ep. 15 : Up. 122000 : Sen. 4,200 : Cost 40.21229553 : Time 2656.50s : 786.17 words/s : L.r. 1.0864e-04
[2018-12-06 04:55:22] Ep. 15 : Up. 123000 : Sen. 74,200 : Cost 38.68326187 : Time 2650.63s : 774.35 words/s : L.r. 1.0820e-04
[2018-12-06 05:39:34] Ep. 15 : Up. 124000 : Sen. 144,200 : Cost 39.49898529 : Time 2651.50s : 784.96 words/s : L.r. 1.0776e-04
[2018-12-06 06:23:43] Ep. 15 : Up. 125000 : Sen. 214,200 : Cost 39.52080536 : Time 2649.22s : 782.98 words/s : L.r. 1.0733e-04
[2018-12-06 07:07:53] Ep. 15 : Up. 126000 : Sen. 284,200 : Cost 39.13751602 : Time 2650.45s : 774.85 words/s : L.r. 1.0690e-04
[2018-12-06 07:52:01] Ep. 15 : Up. 127000 : Sen. 354,200 : Cost 39.32390213 : Time 2647.69s : 776.42 words/s : L.r. 1.0648e-04
[2018-12-06 08:36:08] Ep. 15 : Up. 128000 : Sen. 424,200 : Cost 39.70352554 : Time 2647.57s : 783.98 words/s : L.r. 1.0607e-04
[2018-12-06 09:20:14] Ep. 15 : Up. 129000 : Sen. 494,200 : Cost 39.80657578 : Time 2645.33s : 784.77 words/s : L.r. 1.0565e-04
[2018-12-06 10:04:22] Ep. 15 : Up. 130000 : Sen. 564,200 : Cost 39.73709869 : Time 2648.06s : 781.58 words/s : L.r. 1.0525e-04
[2018-12-06 10:33:06] Seen 609664 samples
[2018-12-06 10:33:06] Starting epoch 16
[2018-12-06 10:33:06] [data] Shuffling files
[2018-12-06 10:33:06] [data] Done reading 620637 sentences
[2018-12-06 10:33:08] [data] Done shuffling 620637 sentences to temp files
[2018-12-06 10:48:35] Ep. 16 : Up. 131000 : Sen. 24,500 : Cost 39.75284576 : Time 2653.15s : 785.69 words/s : L.r. 1.0484e-04
train_trans_batch70.opt32.3.sh: line 26: 18921 Terminated              $marian_home/marian --model model/model.src0tgt0.trans.batch70.opt64.3.npz --type transformer --train-sets corp/europarl.cs-en.docs.train.en.bpe corp/europarl.cs-en.docs.train.cz.bpe --max-length 80 --vocabs corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml --mini-batch 70 --maxi-batch 1000 --early-stopping 15 --valid-freq 15000 --save-freq 15000 --disp-freq 1000 --valid-metrics cross-entropy perplexity translation --valid-sets corp/europarl.cs-en.docs.dev.en.bpe corp/europarl.cs-en.docs.dev.cz.bpe --valid-script-path ./val.sh --valid-translation-output data/valid32.bpe.en.output --quiet-translation --valid-mini-batch 16 --beam-size 6 --normalize 0.6 --log model/train_trans.log --valid-log model/valid_trans.log --enc-depth 6 --dec-depth 6 --transformer-heads 8 --transformer-postprocess-emb d --transformer-postprocess dan --transformer-dropout 0.1 --label-smoothing 0.1 --learn-rate 0.0003 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 --tied-embeddings-all --optimizer-delay 64 --devices 0 --sync-sgd --seed 1111 --exponential-smoothing
