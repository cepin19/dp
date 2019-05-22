[2019-01-15 05:05:16] [marian] Marian v1.7.6 9cc5b17 2018-12-14 15:11:34 -0800
[2019-01-15 05:05:16] [marian] Running on spider3.lingea.cz as process 10220 with command line:
[2019-01-15 05:05:16] [marian] /home/big_maggie/usr/marian_spider/marian_1.7.6/marian-dev/build/marian --model model/model.src1tgt0.newvocab.npz --type transformer --train-sets corp/opensub.en-fr.docs.train.en.bpe corp/opensub.en-fr.docs.train.fr.bpe --max-length 160 --vocabs corp/vocab.encz.opensub.yml corp/vocab.encz.opensub.yml --mini-batch-fit -w 10000 --maxi-batch 1000 --early-stopping 10 --valid-freq 5000 --save-freq 5000 --disp-freq 500 --valid-metrics cross-entropy perplexity translation --valid-sets corp/opensub.en-fr.docs.dev.en.bpe corp/opensub.en-fr.docs.dev.fr.bpe --valid-script-path ./val.sh --valid-translation-output data/valid.bpe.en.output --quiet-translation --valid-mini-batch 64 --beam-size 6 --normalize 0.6 --log model/train_trans.newvocab.log --valid-log model/valid_trans.newvocab.log --enc-depth 6 --dec-depth 6 --transformer-heads 8 --transformer-postprocess-emb d --transformer-postprocess dan --transformer-dropout 0.1 --label-smoothing 0.1 --learn-rate 0.0003 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 --tied-embeddings-all --optimizer-delay 4 --devices 0 1 --sync-sgd --seed 1111 --exponential-smoothing --no-nccl
[2019-01-15 05:05:16] [config] after-batches: 0
[2019-01-15 05:05:16] [config] after-epochs: 0
[2019-01-15 05:05:16] [config] allow-unk: false
[2019-01-15 05:05:16] [config] beam-size: 6
[2019-01-15 05:05:16] [config] best-deep: false
[2019-01-15 05:05:16] [config] clip-gemm: 0
[2019-01-15 05:05:16] [config] clip-norm: 5
[2019-01-15 05:05:16] [config] cost-type: ce-mean
[2019-01-15 05:05:16] [config] cpu-threads: 0
[2019-01-15 05:05:16] [config] data-weighting-type: sentence
[2019-01-15 05:05:16] [config] dec-cell: gru
[2019-01-15 05:05:16] [config] dec-cell-base-depth: 2
[2019-01-15 05:05:16] [config] dec-cell-high-depth: 1
[2019-01-15 05:05:16] [config] dec-depth: 6
[2019-01-15 05:05:16] [config] devices:
[2019-01-15 05:05:16] [config]   - 0
[2019-01-15 05:05:16] [config]   - 1
[2019-01-15 05:05:16] [config] dim-emb: 512
[2019-01-15 05:05:16] [config] dim-rnn: 1024
[2019-01-15 05:05:16] [config] dim-vocabs:
[2019-01-15 05:05:16] [config]   - 0
[2019-01-15 05:05:16] [config]   - 0
[2019-01-15 05:05:16] [config] disp-first: 0
[2019-01-15 05:05:16] [config] disp-freq: 500
[2019-01-15 05:05:16] [config] disp-label-counts: false
[2019-01-15 05:05:16] [config] dropout-rnn: 0
[2019-01-15 05:05:16] [config] dropout-src: 0
[2019-01-15 05:05:16] [config] dropout-trg: 0
[2019-01-15 05:05:16] [config] early-stopping: 10
[2019-01-15 05:05:16] [config] embedding-fix-src: false
[2019-01-15 05:05:16] [config] embedding-fix-trg: false
[2019-01-15 05:05:16] [config] embedding-normalization: false
[2019-01-15 05:05:16] [config] enc-cell: gru
[2019-01-15 05:05:16] [config] enc-cell-depth: 1
[2019-01-15 05:05:16] [config] enc-depth: 6
[2019-01-15 05:05:16] [config] enc-type: bidirectional
[2019-01-15 05:05:16] [config] exponential-smoothing: 0.0001
[2019-01-15 05:05:16] [config] grad-dropping-momentum: 0
[2019-01-15 05:05:16] [config] grad-dropping-rate: 0
[2019-01-15 05:05:16] [config] grad-dropping-warmup: 100
[2019-01-15 05:05:16] [config] guided-alignment: none
[2019-01-15 05:05:16] [config] guided-alignment-cost: mse
[2019-01-15 05:05:16] [config] guided-alignment-weight: 0.1
[2019-01-15 05:05:16] [config] ignore-model-config: false
[2019-01-15 05:05:16] [config] interpolate-env-vars: false
[2019-01-15 05:05:16] [config] keep-best: false
[2019-01-15 05:05:16] [config] label-smoothing: 0.1
[2019-01-15 05:05:16] [config] layer-normalization: false
[2019-01-15 05:05:16] [config] learn-rate: 0.0003
[2019-01-15 05:05:16] [config] log: model/train_trans.newvocab.log
[2019-01-15 05:05:16] [config] log-level: info
[2019-01-15 05:05:16] [config] lr-decay: 0
[2019-01-15 05:05:16] [config] lr-decay-freq: 50000
[2019-01-15 05:05:16] [config] lr-decay-inv-sqrt: 16000
[2019-01-15 05:05:16] [config] lr-decay-repeat-warmup: false
[2019-01-15 05:05:16] [config] lr-decay-reset-optimizer: false
[2019-01-15 05:05:16] [config] lr-decay-start:
[2019-01-15 05:05:16] [config]   - 10
[2019-01-15 05:05:16] [config]   - 1
[2019-01-15 05:05:16] [config] lr-decay-strategy: epoch+stalled
[2019-01-15 05:05:16] [config] lr-report: true
[2019-01-15 05:05:16] [config] lr-warmup: 16000
[2019-01-15 05:05:16] [config] lr-warmup-at-reload: false
[2019-01-15 05:05:16] [config] lr-warmup-cycle: false
[2019-01-15 05:05:16] [config] lr-warmup-start-rate: 0
[2019-01-15 05:05:16] [config] max-length: 160
[2019-01-15 05:05:16] [config] max-length-crop: false
[2019-01-15 05:05:16] [config] max-length-factor: 3
[2019-01-15 05:05:16] [config] maxi-batch: 1000
[2019-01-15 05:05:16] [config] maxi-batch-sort: trg
[2019-01-15 05:05:16] [config] mini-batch: 64
[2019-01-15 05:05:16] [config] mini-batch-fit: true
[2019-01-15 05:05:16] [config] mini-batch-fit-step: 10
[2019-01-15 05:05:16] [config] mini-batch-words: 0
[2019-01-15 05:05:16] [config] model: model/model.src1tgt0.newvocab.npz
[2019-01-15 05:05:16] [config] multi-node: false
[2019-01-15 05:05:16] [config] multi-node-overlap: true
[2019-01-15 05:05:16] [config] n-best: false
[2019-01-15 05:05:16] [config] no-nccl: true
[2019-01-15 05:05:16] [config] no-reload: false
[2019-01-15 05:05:16] [config] no-restore-corpus: false
[2019-01-15 05:05:16] [config] no-shuffle: false
[2019-01-15 05:05:16] [config] normalize: 0.6
[2019-01-15 05:05:16] [config] optimizer: adam
[2019-01-15 05:05:16] [config] optimizer-delay: 4
[2019-01-15 05:05:16] [config] optimizer-params:
[2019-01-15 05:05:16] [config]   - 0.9
[2019-01-15 05:05:16] [config]   - 0.98
[2019-01-15 05:05:16] [config]   - 1e-09
[2019-01-15 05:05:16] [config] overwrite: false
[2019-01-15 05:05:16] [config] quiet: false
[2019-01-15 05:05:16] [config] quiet-translation: true
[2019-01-15 05:05:16] [config] relative-paths: false
[2019-01-15 05:05:16] [config] right-left: false
[2019-01-15 05:05:16] [config] save-freq: 5000
[2019-01-15 05:05:16] [config] seed: 1111
[2019-01-15 05:05:16] [config] sentencepiece-alphas:
[2019-01-15 05:05:16] [config]   []
[2019-01-15 05:05:16] [config] sentencepiece-max-lines: 10000000
[2019-01-15 05:05:16] [config] sentencepiece-options: ""
[2019-01-15 05:05:16] [config] shuffle-in-ram: false
[2019-01-15 05:05:16] [config] skip: false
[2019-01-15 05:05:16] [config] sqlite: ""
[2019-01-15 05:05:16] [config] sqlite-drop: false
[2019-01-15 05:05:16] [config] sync-sgd: true
[2019-01-15 05:05:16] [config] tempdir: /tmp
[2019-01-15 05:05:16] [config] tied-embeddings: false
[2019-01-15 05:05:16] [config] tied-embeddings-all: true
[2019-01-15 05:05:16] [config] tied-embeddings-src: false
[2019-01-15 05:05:16] [config] train-sets:
[2019-01-15 05:05:16] [config]   - corp/opensub.en-fr.docs.train.en.bpe
[2019-01-15 05:05:16] [config]   - corp/opensub.en-fr.docs.train.fr.bpe
[2019-01-15 05:05:16] [config] transformer-aan-activation: swish
[2019-01-15 05:05:16] [config] transformer-aan-depth: 2
[2019-01-15 05:05:16] [config] transformer-aan-nogate: false
[2019-01-15 05:05:16] [config] transformer-decoder-autoreg: self-attention
[2019-01-15 05:05:16] [config] transformer-dim-aan: 2048
[2019-01-15 05:05:16] [config] transformer-dim-ffn: 2048
[2019-01-15 05:05:16] [config] transformer-dropout: 0.1
[2019-01-15 05:05:16] [config] transformer-dropout-attention: 0
[2019-01-15 05:05:16] [config] transformer-dropout-ffn: 0
[2019-01-15 05:05:16] [config] transformer-ffn-activation: swish
[2019-01-15 05:05:16] [config] transformer-ffn-depth: 2
[2019-01-15 05:05:16] [config] transformer-guided-alignment-layer: last
[2019-01-15 05:05:16] [config] transformer-heads: 8
[2019-01-15 05:05:16] [config] transformer-no-projection: false
[2019-01-15 05:05:16] [config] transformer-postprocess: dan
[2019-01-15 05:05:16] [config] transformer-postprocess-emb: d
[2019-01-15 05:05:16] [config] transformer-preprocess: ""
[2019-01-15 05:05:16] [config] transformer-tied-layers:
[2019-01-15 05:05:16] [config]   []
[2019-01-15 05:05:16] [config] type: transformer
[2019-01-15 05:05:16] [config] ulr: false
[2019-01-15 05:05:16] [config] ulr-dim-emb: 0
[2019-01-15 05:05:16] [config] ulr-dropout: 0
[2019-01-15 05:05:16] [config] ulr-keys-vectors: ""
[2019-01-15 05:05:16] [config] ulr-query-vectors: ""
[2019-01-15 05:05:16] [config] ulr-softmax-temperature: 1
[2019-01-15 05:05:16] [config] ulr-trainable-transformation: false
[2019-01-15 05:05:16] [config] valid-freq: 5000
[2019-01-15 05:05:16] [config] valid-log: model/valid_trans.newvocab.log
[2019-01-15 05:05:16] [config] valid-max-length: 1000
[2019-01-15 05:05:16] [config] valid-metrics:
[2019-01-15 05:05:16] [config]   - cross-entropy
[2019-01-15 05:05:16] [config]   - perplexity
[2019-01-15 05:05:16] [config]   - translation
[2019-01-15 05:05:16] [config] valid-mini-batch: 64
[2019-01-15 05:05:16] [config] valid-script-path: ./val.sh
[2019-01-15 05:05:16] [config] valid-sets:
[2019-01-15 05:05:16] [config]   - corp/opensub.en-fr.docs.dev.en.bpe
[2019-01-15 05:05:16] [config]   - corp/opensub.en-fr.docs.dev.fr.bpe
[2019-01-15 05:05:16] [config] valid-translation-output: data/valid.bpe.en.output
[2019-01-15 05:05:16] [config] vocabs:
[2019-01-15 05:05:16] [config]   - corp/vocab.encz.opensub.yml
[2019-01-15 05:05:16] [config]   - corp/vocab.encz.opensub.yml
[2019-01-15 05:05:16] [config] word-penalty: 0
[2019-01-15 05:05:16] [config] workspace: 10000
[2019-01-15 05:05:16] [config] Model is being created with Marian v1.7.6 9cc5b17 2018-12-14 15:11:34 -0800
[2019-01-15 05:05:16] Using synchronous training
[2019-01-15 05:05:16] [data] Creating vocabulary corp/vocab.encz.opensub.yml from corp/opensub.en-fr.docs.train.en.bpe, corp/opensub.en-fr.docs.train.fr.bpe
[2019-01-15 05:09:20] [data] Loading vocabulary from JSON/Yaml file corp/vocab.encz.opensub.yml
[2019-01-15 05:09:20] [data] Setting vocabulary size for input 0 to 33552
[2019-01-15 05:09:20] [data] Loading vocabulary from JSON/Yaml file corp/vocab.encz.opensub.yml
[2019-01-15 05:09:21] [data] Setting vocabulary size for input 1 to 33552
[2019-01-15 05:09:21] [batching] Collecting statistics for batch fitting with step size 10
[2019-01-15 05:09:21] Compiled without MPI support. Falling back to FakeMPIWrapper
[2019-01-15 05:09:25] [memory] Extending reserved space to 10112 MB (device gpu0)
[2019-01-15 05:09:26] [memory] Extending reserved space to 10112 MB (device gpu1)
[2019-01-15 05:09:26] [comm] NCCL communicator overridden
[2019-01-15 05:09:26] [memory] Reserving 234 MB, device gpu0
[2019-01-15 05:09:26] [memory] Reserving 234 MB, device gpu0
[2019-01-15 05:09:48] [batching] Done
[2019-01-15 05:09:48] [memory] Extending reserved space to 10112 MB (device gpu0)
[2019-01-15 05:09:48] [memory] Extending reserved space to 10112 MB (device gpu1)
[2019-01-15 05:09:48] [comm] NCCL communicator overridden
[2019-01-15 05:09:48] Training started
[2019-01-15 05:09:48] [data] Shuffling files
[2019-01-15 05:10:09] [data] Done reading 41736982 sentences
[2019-01-15 05:13:57] [data] Done shuffling 41736982 sentences to temp files
[2019-01-15 05:14:10] [memory] Reserving 234 MB, device gpu0
[2019-01-15 05:14:10] [memory] Reserving 234 MB, device gpu1
[2019-01-15 05:14:11] [memory] Reserving 117 MB, device gpu0
[2019-01-15 05:14:11] [memory] Reserving 117 MB, device gpu1
[2019-01-15 05:14:11] [memory] Reserving 234 MB, device gpu0
[2019-01-15 05:14:11] [memory] Reserving 234 MB, device gpu1
[2019-01-15 05:14:11] [memory] Reserving 117 MB, device gpu0
[2019-01-15 05:14:11] [memory] Reserving 117 MB, device gpu1
[2019-01-15 05:14:11] [memory] Reserving 234 MB, device gpu0
[2019-01-15 05:14:11] [memory] Reserving 234 MB, device gpu1
[2019-01-15 05:21:33] Ep. 1 : Up. 500 : Sen. 662,406 : Cost 91.62329865 : Time 704.91s : 8907.95 words/s : L.r. 9.3750e-06
[2019-01-15 05:29:03] Ep. 1 : Up. 1000 : Sen. 1,319,392 : Cost 72.60583496 : Time 450.29s : 13859.72 words/s : L.r. 1.8750e-05
[2019-01-15 05:36:32] Ep. 1 : Up. 1500 : Sen. 1,978,077 : Cost 62.02021408 : Time 449.29s : 13860.23 words/s : L.r. 2.8125e-05
[2019-01-15 05:43:59] Ep. 1 : Up. 2000 : Sen. 2,630,344 : Cost 57.70200729 : Time 446.59s : 13864.09 words/s : L.r. 3.7500e-05
[2019-01-15 05:51:26] Ep. 1 : Up. 2500 : Sen. 3,282,728 : Cost 53.98640060 : Time 447.12s : 13900.71 words/s : L.r. 4.6875e-05
[2019-01-15 05:58:54] Ep. 1 : Up. 3000 : Sen. 3,940,314 : Cost 50.40290451 : Time 447.57s : 13828.87 words/s : L.r. 5.6250e-05
[2019-01-15 06:06:20] Ep. 1 : Up. 3500 : Sen. 4,589,386 : Cost 48.63618851 : Time 446.41s : 13787.80 words/s : L.r. 6.5625e-05
[2019-01-15 06:13:46] Ep. 1 : Up. 4000 : Sen. 5,239,736 : Cost 46.67933655 : Time 446.13s : 13825.74 words/s : L.r. 7.5000e-05
[2019-01-15 06:21:10] Ep. 1 : Up. 4500 : Sen. 5,887,200 : Cost 44.99371719 : Time 443.58s : 13838.94 words/s : L.r. 8.4375e-05
[2019-01-15 06:28:39] Ep. 1 : Up. 5000 : Sen. 6,544,999 : Cost 43.43611145 : Time 449.06s : 13863.93 words/s : L.r. 9.3750e-05
[2019-01-15 06:28:39] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 06:28:43] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter5000.npz
[2019-01-15 06:28:47] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 06:28:51] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 06:29:01] [valid] Ep. 1 : Up. 5000 : cross-entropy : 57.0348 : new best
[2019-01-15 06:29:04] [valid] Ep. 1 : Up. 5000 : perplexity : 83.5284 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 06:33:08] [valid] Ep. 1 : Up. 5000 : translation : 3.71 : new best
[2019-01-15 06:40:34] Ep. 1 : Up. 5500 : Sen. 7,192,395 : Cost 42.52424622 : Time 715.06s : 8661.99 words/s : L.r. 1.0313e-04
[2019-01-15 06:48:05] Ep. 1 : Up. 6000 : Sen. 7,862,080 : Cost 39.73871613 : Time 450.53s : 13969.17 words/s : L.r. 1.1250e-04
[2019-01-15 06:55:32] Ep. 1 : Up. 6500 : Sen. 8,518,508 : Cost 38.22912979 : Time 447.99s : 13887.14 words/s : L.r. 1.2188e-04
[2019-01-15 07:02:56] Ep. 1 : Up. 7000 : Sen. 9,167,937 : Cost 36.34809494 : Time 443.36s : 13851.48 words/s : L.r. 1.3125e-04
[2019-01-15 07:10:21] Ep. 1 : Up. 7500 : Sen. 9,819,031 : Cost 35.05130005 : Time 444.82s : 13890.22 words/s : L.r. 1.4063e-04
[2019-01-15 07:17:48] Ep. 1 : Up. 8000 : Sen. 10,473,772 : Cost 34.05228043 : Time 447.09s : 13933.78 words/s : L.r. 1.5000e-04
[2019-01-15 07:25:12] Ep. 1 : Up. 8500 : Sen. 11,127,358 : Cost 32.77552032 : Time 444.53s : 13863.12 words/s : L.r. 1.5938e-04
[2019-01-15 07:32:40] Ep. 1 : Up. 9000 : Sen. 11,782,344 : Cost 32.23896027 : Time 447.73s : 13872.00 words/s : L.r. 1.6875e-04
[2019-01-15 07:40:01] Ep. 1 : Up. 9500 : Sen. 12,429,080 : Cost 31.63706017 : Time 441.43s : 13904.76 words/s : L.r. 1.7813e-04
[2019-01-15 07:47:24] Ep. 1 : Up. 10000 : Sen. 13,079,747 : Cost 30.92810631 : Time 442.33s : 13909.69 words/s : L.r. 1.8750e-04
[2019-01-15 07:47:24] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 07:47:28] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter10000.npz
[2019-01-15 07:47:32] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 07:47:36] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 07:47:47] [valid] Ep. 1 : Up. 10000 : cross-entropy : 32.2086 : new best
[2019-01-15 07:47:50] [valid] Ep. 1 : Up. 10000 : perplexity : 12.1702 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 07:50:02] [valid] Ep. 1 : Up. 10000 : translation : 23.64 : new best
[2019-01-15 07:57:28] Ep. 1 : Up. 10500 : Sen. 13,736,014 : Cost 30.72942543 : Time 603.95s : 10337.40 words/s : L.r. 1.9688e-04
[2019-01-15 08:04:52] Ep. 1 : Up. 11000 : Sen. 14,391,666 : Cost 30.11008644 : Time 444.70s : 13914.59 words/s : L.r. 2.0625e-04
[2019-01-15 08:12:15] Ep. 1 : Up. 11500 : Sen. 15,042,007 : Cost 30.00529480 : Time 442.57s : 13939.05 words/s : L.r. 2.1563e-04
[2019-01-15 08:19:41] Ep. 1 : Up. 12000 : Sen. 15,699,038 : Cost 29.69352722 : Time 445.71s : 13982.52 words/s : L.r. 2.2500e-04
[2019-01-15 08:27:09] Ep. 1 : Up. 12500 : Sen. 16,359,089 : Cost 29.62090111 : Time 448.07s : 14017.66 words/s : L.r. 2.3438e-04
[2019-01-15 08:34:34] Ep. 1 : Up. 13000 : Sen. 17,011,491 : Cost 29.39262581 : Time 444.90s : 13948.25 words/s : L.r. 2.4375e-04
[2019-01-15 08:41:56] Ep. 1 : Up. 13500 : Sen. 17,671,249 : Cost 28.67837906 : Time 442.48s : 13983.98 words/s : L.r. 2.5313e-04
[2019-01-15 08:49:20] Ep. 1 : Up. 14000 : Sen. 18,326,362 : Cost 28.94593239 : Time 444.15s : 13989.85 words/s : L.r. 2.6250e-04
[2019-01-15 08:56:42] Ep. 1 : Up. 14500 : Sen. 18,976,193 : Cost 28.75857353 : Time 441.52s : 13940.29 words/s : L.r. 2.7188e-04
[2019-01-15 09:04:01] Ep. 1 : Up. 15000 : Sen. 19,622,774 : Cost 28.69107437 : Time 439.13s : 13989.68 words/s : L.r. 2.8125e-04
[2019-01-15 09:04:01] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 09:04:05] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter15000.npz
[2019-01-15 09:04:09] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 09:04:13] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 09:04:25] [valid] Ep. 1 : Up. 15000 : cross-entropy : 26.2181 : new best
[2019-01-15 09:04:27] [valid] Ep. 1 : Up. 15000 : perplexity : 7.6461 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 09:05:56] [valid] Ep. 1 : Up. 15000 : translation : 28.9 : new best
[2019-01-15 09:13:21] Ep. 1 : Up. 15500 : Sen. 20,282,367 : Cost 28.38707542 : Time 559.71s : 11126.68 words/s : L.r. 2.9063e-04
[2019-01-15 09:20:44] Ep. 1 : Up. 16000 : Sen. 20,938,099 : Cost 28.49691963 : Time 443.29s : 14055.51 words/s : L.r. 3.0000e-04
[2019-01-15 09:28:07] Ep. 1 : Up. 16500 : Sen. 21,599,938 : Cost 27.96781921 : Time 443.10s : 14014.78 words/s : L.r. 2.9542e-04
[2019-01-15 09:35:30] Ep. 1 : Up. 17000 : Sen. 22,250,283 : Cost 28.39806938 : Time 443.01s : 14009.20 words/s : L.r. 2.9104e-04
[2019-01-15 09:42:52] Ep. 1 : Up. 17500 : Sen. 22,901,797 : Cost 28.06167221 : Time 442.07s : 14005.35 words/s : L.r. 2.8685e-04
[2019-01-15 09:50:12] Ep. 1 : Up. 18000 : Sen. 23,555,608 : Cost 27.87865829 : Time 440.17s : 14080.43 words/s : L.r. 2.8284e-04
[2019-01-15 09:57:33] Ep. 1 : Up. 18500 : Sen. 24,206,979 : Cost 27.71032524 : Time 440.43s : 14016.29 words/s : L.r. 2.7899e-04
[2019-01-15 10:04:56] Ep. 1 : Up. 19000 : Sen. 24,863,072 : Cost 27.52238464 : Time 443.04s : 13987.31 words/s : L.r. 2.7530e-04
[2019-01-15 10:12:18] Ep. 1 : Up. 19500 : Sen. 25,513,246 : Cost 27.74186897 : Time 442.35s : 14026.60 words/s : L.r. 2.7175e-04
[2019-01-15 10:19:41] Ep. 1 : Up. 20000 : Sen. 26,170,484 : Cost 27.35229874 : Time 442.72s : 14031.43 words/s : L.r. 2.6833e-04
[2019-01-15 10:19:41] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 10:19:45] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter20000.npz
[2019-01-15 10:19:49] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 10:19:53] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 10:20:04] [valid] Ep. 1 : Up. 20000 : cross-entropy : 24.1904 : new best
[2019-01-15 10:20:07] [valid] Ep. 1 : Up. 20000 : perplexity : 6.53305 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 10:21:28] [valid] Ep. 1 : Up. 20000 : translation : 30.78 : new best
[2019-01-15 10:28:48] Ep. 1 : Up. 20500 : Sen. 26,818,120 : Cost 27.35538864 : Time 546.75s : 11234.97 words/s : L.r. 2.6504e-04
[2019-01-15 10:36:13] Ep. 1 : Up. 21000 : Sen. 27,482,290 : Cost 27.16109467 : Time 444.97s : 14105.68 words/s : L.r. 2.6186e-04
[2019-01-15 10:43:31] Ep. 1 : Up. 21500 : Sen. 28,127,847 : Cost 27.26577759 : Time 438.86s : 13985.83 words/s : L.r. 2.5880e-04
[2019-01-15 10:50:52] Ep. 1 : Up. 22000 : Sen. 28,780,714 : Cost 27.06495285 : Time 440.13s : 14042.25 words/s : L.r. 2.5584e-04
[2019-01-15 10:58:15] Ep. 1 : Up. 22500 : Sen. 29,437,554 : Cost 26.87907791 : Time 443.58s : 13971.96 words/s : L.r. 2.5298e-04
[2019-01-15 11:05:41] Ep. 1 : Up. 23000 : Sen. 30,092,363 : Cost 27.02336121 : Time 446.19s : 13944.25 words/s : L.r. 2.5022e-04
[2019-01-15 11:13:01] Ep. 1 : Up. 23500 : Sen. 30,743,877 : Cost 26.66207314 : Time 439.16s : 13953.38 words/s : L.r. 2.4754e-04
[2019-01-15 11:20:27] Ep. 1 : Up. 24000 : Sen. 31,400,310 : Cost 26.88948250 : Time 446.18s : 13972.23 words/s : L.r. 2.4495e-04
[2019-01-15 11:27:53] Ep. 1 : Up. 24500 : Sen. 32,053,328 : Cost 26.89449692 : Time 446.20s : 13929.93 words/s : L.r. 2.4244e-04
[2019-01-15 11:35:19] Ep. 1 : Up. 25000 : Sen. 32,714,633 : Cost 26.54529762 : Time 446.45s : 13957.05 words/s : L.r. 2.4000e-04
[2019-01-15 11:35:19] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 11:35:24] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter25000.npz
[2019-01-15 11:35:27] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 11:35:31] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 11:35:42] [valid] Ep. 1 : Up. 25000 : cross-entropy : 23.0691 : new best
[2019-01-15 11:35:45] [valid] Ep. 1 : Up. 25000 : perplexity : 5.98871 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 11:37:12] [valid] Ep. 1 : Up. 25000 : translation : 31.71 : new best
[2019-01-15 11:44:38] Ep. 1 : Up. 25500 : Sen. 33,362,720 : Cost 27.02264595 : Time 558.18s : 11134.14 words/s : L.r. 2.3764e-04
[2019-01-15 11:52:04] Ep. 1 : Up. 26000 : Sen. 34,025,230 : Cost 26.30723381 : Time 446.63s : 13925.49 words/s : L.r. 2.3534e-04
[2019-01-15 11:59:28] Ep. 1 : Up. 26500 : Sen. 34,678,344 : Cost 26.58342934 : Time 443.92s : 13960.20 words/s : L.r. 2.3311e-04
[2019-01-15 12:06:51] Ep. 1 : Up. 27000 : Sen. 35,328,324 : Cost 26.49452209 : Time 443.14s : 13889.14 words/s : L.r. 2.3094e-04
[2019-01-15 12:14:20] Ep. 1 : Up. 27500 : Sen. 35,988,064 : Cost 26.39037132 : Time 448.63s : 13901.47 words/s : L.r. 2.2883e-04
[2019-01-15 12:21:50] Ep. 1 : Up. 28000 : Sen. 36,643,231 : Cost 26.58534050 : Time 450.25s : 13847.07 words/s : L.r. 2.2678e-04
[2019-01-15 12:29:18] Ep. 1 : Up. 28500 : Sen. 37,303,766 : Cost 26.15823174 : Time 447.58s : 13901.66 words/s : L.r. 2.2478e-04
[2019-01-15 12:36:50] Ep. 1 : Up. 29000 : Sen. 37,961,227 : Cost 26.56769562 : Time 452.05s : 13869.27 words/s : L.r. 2.2283e-04
[2019-01-15 12:44:20] Ep. 1 : Up. 29500 : Sen. 38,621,638 : Cost 26.21946335 : Time 449.97s : 13888.90 words/s : L.r. 2.2094e-04
[2019-01-15 12:51:46] Ep. 1 : Up. 30000 : Sen. 39,274,428 : Cost 26.20549583 : Time 446.04s : 13829.67 words/s : L.r. 2.1909e-04
[2019-01-15 12:51:46] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 12:51:50] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter30000.npz
[2019-01-15 12:51:53] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 12:51:58] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 12:52:09] [valid] Ep. 1 : Up. 30000 : cross-entropy : 22.3743 : new best
[2019-01-15 12:52:12] [valid] Ep. 1 : Up. 30000 : perplexity : 5.67441 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 12:53:34] [valid] Ep. 1 : Up. 30000 : translation : 32.36 : new best
[2019-01-15 13:00:56] Ep. 1 : Up. 30500 : Sen. 39,918,036 : Cost 26.32249832 : Time 549.90s : 11110.61 words/s : L.r. 2.1729e-04
[2019-01-15 13:08:26] Ep. 1 : Up. 31000 : Sen. 40,574,984 : Cost 26.19305611 : Time 450.16s : 13831.02 words/s : L.r. 2.1553e-04
[2019-01-15 13:15:52] Ep. 1 : Up. 31500 : Sen. 41,224,740 : Cost 26.28704643 : Time 446.20s : 13856.01 words/s : L.r. 2.1381e-04
[2019-01-15 13:21:44] Seen 41736931 samples
[2019-01-15 13:21:44] Starting epoch 2
[2019-01-15 13:21:44] [data] Shuffling files
[2019-01-15 13:21:59] [data] Done reading 41736982 sentences
[2019-01-15 13:25:45] [data] Done shuffling 41736982 sentences to temp files
[2019-01-15 13:27:27] Ep. 2 : Up. 32000 : Sen. 137,456 : Cost 26.02362251 : Time 695.11s : 8833.38 words/s : L.r. 2.1213e-04
[2019-01-15 13:34:51] Ep. 2 : Up. 32500 : Sen. 785,245 : Cost 26.01823425 : Time 443.46s : 13851.77 words/s : L.r. 2.1049e-04
[2019-01-15 13:42:17] Ep. 2 : Up. 33000 : Sen. 1,441,388 : Cost 25.78697395 : Time 446.68s : 13828.95 words/s : L.r. 2.0889e-04
[2019-01-15 13:49:48] Ep. 2 : Up. 33500 : Sen. 2,093,914 : Cost 26.16168594 : Time 450.46s : 13816.06 words/s : L.r. 2.0733e-04
[2019-01-15 13:57:16] Ep. 2 : Up. 34000 : Sen. 2,747,476 : Cost 25.96262360 : Time 448.56s : 13806.31 words/s : L.r. 2.0580e-04
[2019-01-15 14:04:47] Ep. 2 : Up. 34500 : Sen. 3,406,955 : Cost 25.89040756 : Time 451.04s : 13840.57 words/s : L.r. 2.0430e-04
[2019-01-15 14:12:18] Ep. 2 : Up. 35000 : Sen. 4,064,939 : Cost 25.81528473 : Time 451.10s : 13765.97 words/s : L.r. 2.0284e-04
[2019-01-15 14:12:18] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 14:12:23] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter35000.npz
[2019-01-15 14:12:27] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 14:12:31] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 14:12:41] [valid] Ep. 2 : Up. 35000 : cross-entropy : 21.9023 : new best
[2019-01-15 14:12:44] [valid] Ep. 2 : Up. 35000 : perplexity : 5.47036 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 14:14:12] [valid] Ep. 2 : Up. 35000 : translation : 32.97 : new best
[2019-01-15 14:21:44] Ep. 2 : Up. 35500 : Sen. 4,726,157 : Cost 25.83381653 : Time 565.61s : 11074.21 words/s : L.r. 2.0140e-04
[2019-01-15 14:29:14] Ep. 2 : Up. 36000 : Sen. 5,378,401 : Cost 26.01001167 : Time 450.15s : 13805.97 words/s : L.r. 2.0000e-04
[2019-01-15 14:36:44] Ep. 2 : Up. 36500 : Sen. 6,032,628 : Cost 25.78490067 : Time 450.05s : 13753.42 words/s : L.r. 1.9863e-04
[2019-01-15 14:44:18] Ep. 2 : Up. 37000 : Sen. 6,694,014 : Cost 25.84446526 : Time 453.39s : 13832.22 words/s : L.r. 1.9728e-04
[2019-01-15 14:51:51] Ep. 2 : Up. 37500 : Sen. 7,353,311 : Cost 25.79850006 : Time 453.88s : 13756.77 words/s : L.r. 1.9596e-04
[2019-01-15 14:59:20] Ep. 2 : Up. 38000 : Sen. 8,004,888 : Cost 25.75413895 : Time 448.41s : 13781.21 words/s : L.r. 1.9467e-04
[2019-01-15 15:06:50] Ep. 2 : Up. 38500 : Sen. 8,657,271 : Cost 25.83698463 : Time 450.44s : 13766.56 words/s : L.r. 1.9340e-04
[2019-01-15 15:14:22] Ep. 2 : Up. 39000 : Sen. 9,316,725 : Cost 25.72218323 : Time 451.73s : 13842.84 words/s : L.r. 1.9215e-04
[2019-01-15 15:21:51] Ep. 2 : Up. 39500 : Sen. 9,969,606 : Cost 25.54290581 : Time 448.98s : 13703.54 words/s : L.r. 1.9093e-04
[2019-01-15 15:29:21] Ep. 2 : Up. 40000 : Sen. 10,620,749 : Cost 25.84990311 : Time 449.64s : 13796.34 words/s : L.r. 1.8974e-04
[2019-01-15 15:29:21] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 15:29:25] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter40000.npz
[2019-01-15 15:29:28] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 15:29:33] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 15:29:43] [valid] Ep. 2 : Up. 40000 : cross-entropy : 21.5373 : new best
[2019-01-15 15:29:46] [valid] Ep. 2 : Up. 40000 : perplexity : 5.31764 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 15:31:11] [valid] Ep. 2 : Up. 40000 : translation : 33.25 : new best
[2019-01-15 15:38:44] Ep. 2 : Up. 40500 : Sen. 11,278,766 : Cost 25.69937897 : Time 563.36s : 11085.25 words/s : L.r. 1.8856e-04
[2019-01-15 15:46:16] Ep. 2 : Up. 41000 : Sen. 11,938,694 : Cost 25.47292519 : Time 451.66s : 13756.38 words/s : L.r. 1.8741e-04
[2019-01-15 15:53:46] Ep. 2 : Up. 41500 : Sen. 12,591,839 : Cost 25.58894157 : Time 450.43s : 13733.77 words/s : L.r. 1.8628e-04
[2019-01-15 16:01:16] Ep. 2 : Up. 42000 : Sen. 13,241,087 : Cost 25.67120743 : Time 450.22s : 13698.87 words/s : L.r. 1.8516e-04
[2019-01-15 16:08:45] Ep. 2 : Up. 42500 : Sen. 13,890,437 : Cost 25.63486671 : Time 448.70s : 13734.56 words/s : L.r. 1.8407e-04
[2019-01-15 16:16:18] Ep. 2 : Up. 43000 : Sen. 14,549,037 : Cost 25.75148582 : Time 453.14s : 13842.48 words/s : L.r. 1.8300e-04
[2019-01-15 16:23:53] Ep. 2 : Up. 43500 : Sen. 15,213,586 : Cost 25.43699265 : Time 455.08s : 13770.16 words/s : L.r. 1.8194e-04
[2019-01-15 16:31:21] Ep. 2 : Up. 44000 : Sen. 15,862,487 : Cost 25.51368141 : Time 447.89s : 13703.57 words/s : L.r. 1.8091e-04
[2019-01-15 16:38:51] Ep. 2 : Up. 44500 : Sen. 16,515,127 : Cost 25.55978203 : Time 449.52s : 13772.93 words/s : L.r. 1.7989e-04
[2019-01-15 16:46:20] Ep. 2 : Up. 45000 : Sen. 17,168,011 : Cost 25.41282463 : Time 448.95s : 13721.69 words/s : L.r. 1.7889e-04
[2019-01-15 16:46:20] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 16:46:24] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter45000.npz
[2019-01-15 16:46:27] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 16:46:32] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 16:46:43] [valid] Ep. 2 : Up. 45000 : cross-entropy : 21.2497 : new best
[2019-01-15 16:46:46] [valid] Ep. 2 : Up. 45000 : perplexity : 5.20026 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 16:48:11] [valid] Ep. 2 : Up. 45000 : translation : 33.59 : new best
[2019-01-15 16:55:41] Ep. 2 : Up. 45500 : Sen. 17,821,041 : Cost 25.47991371 : Time 561.02s : 11022.93 words/s : L.r. 1.7790e-04
[2019-01-15 17:03:10] Ep. 2 : Up. 46000 : Sen. 18,476,538 : Cost 25.32639694 : Time 449.63s : 13735.69 words/s : L.r. 1.7693e-04
[2019-01-15 17:10:42] Ep. 2 : Up. 46500 : Sen. 19,131,392 : Cost 25.70314026 : Time 451.65s : 13853.86 words/s : L.r. 1.7598e-04
[2019-01-15 17:18:09] Ep. 2 : Up. 47000 : Sen. 19,782,743 : Cost 25.38758087 : Time 446.92s : 13786.76 words/s : L.r. 1.7504e-04
[2019-01-15 17:25:38] Ep. 2 : Up. 47500 : Sen. 20,441,749 : Cost 25.24127769 : Time 449.02s : 13814.30 words/s : L.r. 1.7411e-04
[2019-01-15 17:33:01] Ep. 2 : Up. 48000 : Sen. 21,083,513 : Cost 25.59886932 : Time 443.12s : 13817.36 words/s : L.r. 1.7321e-04
[2019-01-15 17:40:31] Ep. 2 : Up. 48500 : Sen. 21,742,309 : Cost 25.41356277 : Time 450.34s : 13885.53 words/s : L.r. 1.7231e-04
[2019-01-15 17:47:58] Ep. 2 : Up. 49000 : Sen. 22,391,760 : Cost 25.38053131 : Time 446.16s : 13784.47 words/s : L.r. 1.7143e-04
[2019-01-15 17:55:24] Ep. 2 : Up. 49500 : Sen. 23,041,936 : Cost 25.38881111 : Time 446.58s : 13799.81 words/s : L.r. 1.7056e-04
[2019-01-15 18:02:53] Ep. 2 : Up. 50000 : Sen. 23,700,232 : Cost 25.26723862 : Time 449.04s : 13849.08 words/s : L.r. 1.6971e-04
[2019-01-15 18:02:53] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 18:02:57] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter50000.npz
[2019-01-15 18:03:01] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 18:03:05] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 18:03:15] [valid] Ep. 2 : Up. 50000 : cross-entropy : 21.0303 : new best
[2019-01-15 18:03:18] [valid] Ep. 2 : Up. 50000 : perplexity : 5.11251 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 18:04:45] [valid] Ep. 2 : Up. 50000 : translation : 33.79 : new best
[2019-01-15 18:12:15] Ep. 2 : Up. 50500 : Sen. 24,356,567 : Cost 25.36590385 : Time 562.32s : 11073.52 words/s : L.r. 1.6886e-04
[2019-01-15 18:19:44] Ep. 2 : Up. 51000 : Sen. 25,011,430 : Cost 25.47522926 : Time 448.40s : 13917.31 words/s : L.r. 1.6803e-04
[2019-01-15 18:27:11] Ep. 2 : Up. 51500 : Sen. 25,667,562 : Cost 25.14438057 : Time 446.66s : 13838.86 words/s : L.r. 1.6722e-04
[2019-01-15 18:34:40] Ep. 2 : Up. 52000 : Sen. 26,326,344 : Cost 25.30784988 : Time 449.35s : 13891.92 words/s : L.r. 1.6641e-04
[2019-01-15 18:42:06] Ep. 2 : Up. 52500 : Sen. 26,984,712 : Cost 25.12516022 : Time 445.96s : 13913.85 words/s : L.r. 1.6562e-04
[2019-01-15 18:49:32] Ep. 2 : Up. 53000 : Sen. 27,634,587 : Cost 25.43686295 : Time 446.20s : 13872.97 words/s : L.r. 1.6483e-04
[2019-01-15 18:57:02] Ep. 2 : Up. 53500 : Sen. 28,292,888 : Cost 25.19173050 : Time 449.65s : 13846.26 words/s : L.r. 1.6406e-04
[2019-01-15 19:04:30] Ep. 2 : Up. 54000 : Sen. 28,950,795 : Cost 25.24488449 : Time 448.76s : 13887.57 words/s : L.r. 1.6330e-04
[2019-01-15 19:11:54] Ep. 2 : Up. 54500 : Sen. 29,603,091 : Cost 25.18085289 : Time 443.60s : 13898.91 words/s : L.r. 1.6255e-04
[2019-01-15 19:19:19] Ep. 2 : Up. 55000 : Sen. 30,254,873 : Cost 25.36403656 : Time 445.34s : 13927.70 words/s : L.r. 1.6181e-04
[2019-01-15 19:19:19] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 19:19:24] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter55000.npz
[2019-01-15 19:19:27] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 19:19:31] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 19:19:42] [valid] Ep. 2 : Up. 55000 : cross-entropy : 20.8358 : new best
[2019-01-15 19:19:45] [valid] Ep. 2 : Up. 55000 : perplexity : 5.03591 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 19:21:10] [valid] Ep. 2 : Up. 55000 : translation : 33.81 : new best
[2019-01-15 19:28:35] Ep. 2 : Up. 55500 : Sen. 30,907,944 : Cost 25.25301552 : Time 555.52s : 11153.70 words/s : L.r. 1.6108e-04
[2019-01-15 19:35:57] Ep. 2 : Up. 56000 : Sen. 31,557,842 : Cost 25.16125679 : Time 442.41s : 13883.26 words/s : L.r. 1.6036e-04
[2019-01-15 19:43:21] Ep. 2 : Up. 56500 : Sen. 32,211,188 : Cost 25.21323967 : Time 444.16s : 13942.67 words/s : L.r. 1.5965e-04
[2019-01-15 19:50:48] Ep. 2 : Up. 57000 : Sen. 32,868,371 : Cost 25.29778099 : Time 446.29s : 14004.99 words/s : L.r. 1.5894e-04
[2019-01-15 19:58:10] Ep. 2 : Up. 57500 : Sen. 33,519,996 : Cost 24.94545555 : Time 441.98s : 13840.86 words/s : L.r. 1.5825e-04
[2019-01-15 20:05:32] Ep. 2 : Up. 58000 : Sen. 34,168,333 : Cost 25.38831139 : Time 442.38s : 13985.62 words/s : L.r. 1.5757e-04
[2019-01-15 20:13:01] Ep. 2 : Up. 58500 : Sen. 34,831,124 : Cost 25.25058365 : Time 448.99s : 14034.52 words/s : L.r. 1.5689e-04
[2019-01-15 20:20:25] Ep. 2 : Up. 59000 : Sen. 35,482,619 : Cost 25.25836372 : Time 443.91s : 13951.78 words/s : L.r. 1.5623e-04
[2019-01-15 20:27:51] Ep. 2 : Up. 59500 : Sen. 36,143,113 : Cost 25.04440880 : Time 446.33s : 13987.50 words/s : L.r. 1.5557e-04
[2019-01-15 20:35:15] Ep. 2 : Up. 60000 : Sen. 36,800,000 : Cost 25.13005829 : Time 444.03s : 14019.33 words/s : L.r. 1.5492e-04
[2019-01-15 20:35:15] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 20:35:19] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter60000.npz
[2019-01-15 20:35:23] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 20:35:28] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 20:35:38] [valid] Ep. 2 : Up. 60000 : cross-entropy : 20.6725 : new best
[2019-01-15 20:35:41] [valid] Ep. 2 : Up. 60000 : perplexity : 4.97254 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 20:37:08] [valid] Ep. 2 : Up. 60000 : translation : 33.9 : new best
[2019-01-15 20:44:33] Ep. 2 : Up. 60500 : Sen. 37,454,114 : Cost 25.40299988 : Time 557.85s : 11218.19 words/s : L.r. 1.5428e-04
[2019-01-15 20:51:59] Ep. 2 : Up. 61000 : Sen. 38,111,526 : Cost 25.08864212 : Time 445.57s : 13961.43 words/s : L.r. 1.5364e-04
[2019-01-15 20:59:23] Ep. 2 : Up. 61500 : Sen. 38,772,399 : Cost 24.84233284 : Time 444.66s : 13950.19 words/s : L.r. 1.5302e-04
[2019-01-15 21:06:43] Ep. 2 : Up. 62000 : Sen. 39,418,456 : Cost 25.17741394 : Time 439.51s : 13974.01 words/s : L.r. 1.5240e-04
[2019-01-15 21:14:07] Ep. 2 : Up. 62500 : Sen. 40,075,149 : Cost 25.09160995 : Time 444.26s : 14015.87 words/s : L.r. 1.5179e-04
[2019-01-15 21:21:31] Ep. 2 : Up. 63000 : Sen. 40,731,921 : Cost 25.07408142 : Time 443.88s : 14027.00 words/s : L.r. 1.5119e-04
[2019-01-15 21:28:52] Ep. 2 : Up. 63500 : Sen. 41,383,395 : Cost 24.96124840 : Time 441.17s : 13927.20 words/s : L.r. 1.5059e-04
[2019-01-15 21:32:52] Seen 41736931 samples
[2019-01-15 21:32:52] Starting epoch 3
[2019-01-15 21:32:52] [data] Shuffling files
[2019-01-15 21:33:07] [data] Done reading 41736982 sentences
[2019-01-15 21:36:53] [data] Done shuffling 41736982 sentences to temp files
[2019-01-15 21:40:22] Ep. 3 : Up. 64000 : Sen. 299,257 : Cost 24.93874931 : Time 690.01s : 8945.62 words/s : L.r. 1.5000e-04
[2019-01-15 21:47:45] Ep. 3 : Up. 64500 : Sen. 951,797 : Cost 25.02566338 : Time 442.41s : 14032.19 words/s : L.r. 1.4942e-04
[2019-01-15 21:55:06] Ep. 3 : Up. 65000 : Sen. 1,604,644 : Cost 25.02923203 : Time 441.38s : 14058.79 words/s : L.r. 1.4884e-04
[2019-01-15 21:55:06] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 21:55:10] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter65000.npz
[2019-01-15 21:55:15] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 21:55:19] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 21:55:31] [valid] Ep. 3 : Up. 65000 : cross-entropy : 20.5273 : new best
[2019-01-15 21:55:34] [valid] Ep. 3 : Up. 65000 : perplexity : 4.91682 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 21:57:00] [valid] Ep. 3 : Up. 65000 : translation : 33.95 : new best
[2019-01-15 22:04:28] Ep. 3 : Up. 65500 : Sen. 2,268,704 : Cost 24.84653854 : Time 561.62s : 11180.22 words/s : L.r. 1.4827e-04
[2019-01-15 22:11:51] Ep. 3 : Up. 66000 : Sen. 2,925,295 : Cost 24.89338303 : Time 443.04s : 14024.87 words/s : L.r. 1.4771e-04
[2019-01-15 22:19:16] Ep. 3 : Up. 66500 : Sen. 3,582,923 : Cost 24.98620415 : Time 445.50s : 14014.66 words/s : L.r. 1.4715e-04
[2019-01-15 22:26:40] Ep. 3 : Up. 67000 : Sen. 4,236,614 : Cost 25.01978874 : Time 443.63s : 14004.05 words/s : L.r. 1.4660e-04
[2019-01-15 22:34:05] Ep. 3 : Up. 67500 : Sen. 4,890,532 : Cost 24.99563026 : Time 444.91s : 13971.46 words/s : L.r. 1.4606e-04
[2019-01-15 22:41:30] Ep. 3 : Up. 68000 : Sen. 5,549,709 : Cost 24.84521294 : Time 445.17s : 14004.97 words/s : L.r. 1.4552e-04
[2019-01-15 22:48:49] Ep. 3 : Up. 68500 : Sen. 6,194,373 : Cost 24.88982773 : Time 439.20s : 13905.16 words/s : L.r. 1.4499e-04
[2019-01-15 22:56:20] Ep. 3 : Up. 69000 : Sen. 6,857,403 : Cost 24.85115623 : Time 450.68s : 13919.23 words/s : L.r. 1.4446e-04
[2019-01-15 23:03:47] Ep. 3 : Up. 69500 : Sen. 7,515,426 : Cost 24.78134727 : Time 446.93s : 13895.21 words/s : L.r. 1.4394e-04
[2019-01-15 23:11:12] Ep. 3 : Up. 70000 : Sen. 8,168,014 : Cost 24.94561768 : Time 445.29s : 13908.68 words/s : L.r. 1.4343e-04
[2019-01-15 23:11:12] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-15 23:11:17] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter70000.npz
[2019-01-15 23:11:20] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-15 23:11:25] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-15 23:11:36] [valid] Ep. 3 : Up. 70000 : cross-entropy : 20.4142 : new best
[2019-01-15 23:11:39] [valid] Ep. 3 : Up. 70000 : perplexity : 4.87388 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-15 23:12:56] [valid] Ep. 3 : Up. 70000 : translation : 34.01 : new best
[2019-01-15 23:20:22] Ep. 3 : Up. 70500 : Sen. 8,817,793 : Cost 24.94648552 : Time 549.65s : 11235.86 words/s : L.r. 1.4292e-04
[2019-01-15 23:27:46] Ep. 3 : Up. 71000 : Sen. 9,472,000 : Cost 24.84767723 : Time 444.67s : 13921.30 words/s : L.r. 1.4241e-04
[2019-01-15 23:35:08] Ep. 3 : Up. 71500 : Sen. 10,118,025 : Cost 24.92821503 : Time 441.47s : 13893.99 words/s : L.r. 1.4191e-04
[2019-01-15 23:42:34] Ep. 3 : Up. 72000 : Sen. 10,772,435 : Cost 24.87105560 : Time 445.82s : 13907.86 words/s : L.r. 1.4142e-04
[2019-01-15 23:50:03] Ep. 3 : Up. 72500 : Sen. 11,431,100 : Cost 25.01575851 : Time 449.63s : 13954.97 words/s : L.r. 1.4093e-04
[2019-01-15 23:57:29] Ep. 3 : Up. 73000 : Sen. 12,086,764 : Cost 24.70503426 : Time 445.59s : 13873.75 words/s : L.r. 1.4045e-04
[2019-01-16 00:04:53] Ep. 3 : Up. 73500 : Sen. 12,737,640 : Cost 24.91445923 : Time 444.26s : 13916.11 words/s : L.r. 1.3997e-04
[2019-01-16 00:12:19] Ep. 3 : Up. 74000 : Sen. 13,393,727 : Cost 24.85377312 : Time 446.05s : 13936.41 words/s : L.r. 1.3950e-04
[2019-01-16 00:19:43] Ep. 3 : Up. 74500 : Sen. 14,045,364 : Cost 24.73941040 : Time 444.17s : 13842.05 words/s : L.r. 1.3903e-04
[2019-01-16 00:27:14] Ep. 3 : Up. 75000 : Sen. 14,704,572 : Cost 25.02034569 : Time 451.11s : 13932.24 words/s : L.r. 1.3856e-04
[2019-01-16 00:27:14] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 00:27:19] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter75000.npz
[2019-01-16 00:27:22] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 00:27:27] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 00:27:37] [valid] Ep. 3 : Up. 75000 : cross-entropy : 20.3131 : new best
[2019-01-16 00:27:40] [valid] Ep. 3 : Up. 75000 : perplexity : 4.83579 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 00:29:03] [valid] Ep. 3 : Up. 75000 : translation : 34.08 : new best
[2019-01-16 00:36:30] Ep. 3 : Up. 75500 : Sen. 15,361,298 : Cost 24.72827148 : Time 555.92s : 11155.44 words/s : L.r. 1.3810e-04
[2019-01-16 00:43:59] Ep. 3 : Up. 76000 : Sen. 16,012,268 : Cost 24.87075424 : Time 448.53s : 13772.23 words/s : L.r. 1.3765e-04
[2019-01-16 00:51:27] Ep. 3 : Up. 76500 : Sen. 16,671,964 : Cost 24.70278549 : Time 447.92s : 13909.86 words/s : L.r. 1.3720e-04
[2019-01-16 00:58:58] Ep. 3 : Up. 77000 : Sen. 17,330,328 : Cost 24.70755768 : Time 451.15s : 13779.53 words/s : L.r. 1.3675e-04
[2019-01-16 01:06:27] Ep. 3 : Up. 77500 : Sen. 17,981,048 : Cost 25.02097130 : Time 448.84s : 13834.80 words/s : L.r. 1.3631e-04
[2019-01-16 01:13:57] Ep. 3 : Up. 78000 : Sen. 18,637,636 : Cost 24.80257988 : Time 449.94s : 13817.51 words/s : L.r. 1.3587e-04
[2019-01-16 01:21:26] Ep. 3 : Up. 78500 : Sen. 19,292,385 : Cost 24.54730225 : Time 448.81s : 13705.62 words/s : L.r. 1.3544e-04
[2019-01-16 01:28:55] Ep. 3 : Up. 79000 : Sen. 19,942,414 : Cost 25.03271675 : Time 448.90s : 13839.60 words/s : L.r. 1.3501e-04
[2019-01-16 01:36:26] Ep. 3 : Up. 79500 : Sen. 20,600,300 : Cost 24.69077110 : Time 451.12s : 13785.69 words/s : L.r. 1.3459e-04
[2019-01-16 01:43:56] Ep. 3 : Up. 80000 : Sen. 21,257,682 : Cost 24.82570648 : Time 450.78s : 13855.54 words/s : L.r. 1.3416e-04
[2019-01-16 01:43:56] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 01:44:01] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter80000.npz
[2019-01-16 01:44:04] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 01:44:08] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 01:44:19] [valid] Ep. 3 : Up. 80000 : cross-entropy : 20.2144 : new best
[2019-01-16 01:44:22] [valid] Ep. 3 : Up. 80000 : perplexity : 4.7989 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 01:45:45] [valid] Ep. 3 : Up. 80000 : translation : 34.24 : new best
[2019-01-16 01:53:19] Ep. 3 : Up. 80500 : Sen. 21,922,247 : Cost 24.62027550 : Time 562.34s : 11139.41 words/s : L.r. 1.3375e-04
[2019-01-16 02:00:46] Ep. 3 : Up. 81000 : Sen. 22,567,012 : Cost 24.93770981 : Time 447.28s : 13728.85 words/s : L.r. 1.3333e-04
[2019-01-16 02:08:16] Ep. 3 : Up. 81500 : Sen. 23,222,732 : Cost 24.73900414 : Time 450.01s : 13792.72 words/s : L.r. 1.3292e-04
[2019-01-16 02:15:53] Ep. 3 : Up. 82000 : Sen. 23,886,808 : Cost 24.72979736 : Time 456.90s : 13753.14 words/s : L.r. 1.3252e-04
[2019-01-16 02:23:22] Ep. 3 : Up. 82500 : Sen. 24,540,825 : Cost 24.74420547 : Time 448.79s : 13815.50 words/s : L.r. 1.3212e-04
[2019-01-16 02:30:51] Ep. 3 : Up. 83000 : Sen. 25,191,762 : Cost 24.78602791 : Time 448.84s : 13761.30 words/s : L.r. 1.3172e-04
[2019-01-16 02:38:22] Ep. 3 : Up. 83500 : Sen. 25,848,104 : Cost 24.66810989 : Time 451.73s : 13735.34 words/s : L.r. 1.3132e-04
[2019-01-16 02:45:54] Ep. 3 : Up. 84000 : Sen. 26,504,031 : Cost 24.85181046 : Time 452.08s : 13805.69 words/s : L.r. 1.3093e-04
[2019-01-16 02:53:28] Ep. 3 : Up. 84500 : Sen. 27,165,778 : Cost 24.64723587 : Time 453.91s : 13778.82 words/s : L.r. 1.3054e-04
[2019-01-16 03:00:59] Ep. 3 : Up. 85000 : Sen. 27,817,192 : Cost 24.70074844 : Time 450.79s : 13687.36 words/s : L.r. 1.3016e-04
[2019-01-16 03:00:59] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 03:01:04] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter85000.npz
[2019-01-16 03:01:07] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 03:01:12] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 03:01:23] [valid] Ep. 3 : Up. 85000 : cross-entropy : 20.124 : new best
[2019-01-16 03:01:26] [valid] Ep. 3 : Up. 85000 : perplexity : 4.76535 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 03:02:50] [valid] Ep. 3 : Up. 85000 : translation : 34.27 : new best
[2019-01-16 03:10:23] Ep. 3 : Up. 85500 : Sen. 28,474,105 : Cost 24.68066406 : Time 564.03s : 11014.51 words/s : L.r. 1.2978e-04
[2019-01-16 03:17:55] Ep. 3 : Up. 86000 : Sen. 29,130,556 : Cost 24.82493401 : Time 452.28s : 13805.75 words/s : L.r. 1.2940e-04
[2019-01-16 03:25:24] Ep. 3 : Up. 86500 : Sen. 29,779,949 : Cost 24.79708672 : Time 448.51s : 13771.76 words/s : L.r. 1.2902e-04
[2019-01-16 03:32:50] Ep. 3 : Up. 87000 : Sen. 30,426,851 : Cost 24.67514801 : Time 445.74s : 13740.36 words/s : L.r. 1.2865e-04
[2019-01-16 03:40:23] Ep. 3 : Up. 87500 : Sen. 31,090,772 : Cost 24.36805534 : Time 453.50s : 13694.80 words/s : L.r. 1.2829e-04
[2019-01-16 03:47:53] Ep. 3 : Up. 88000 : Sen. 31,740,503 : Cost 24.92005157 : Time 449.98s : 13796.09 words/s : L.r. 1.2792e-04
[2019-01-16 03:55:27] Ep. 3 : Up. 88500 : Sen. 32,399,724 : Cost 24.63576508 : Time 453.64s : 13746.28 words/s : L.r. 1.2756e-04
[2019-01-16 04:03:01] Ep. 3 : Up. 89000 : Sen. 33,059,206 : Cost 24.75568199 : Time 454.47s : 13786.41 words/s : L.r. 1.2720e-04
[2019-01-16 04:10:30] Ep. 3 : Up. 89500 : Sen. 33,716,087 : Cost 24.43858910 : Time 449.08s : 13755.84 words/s : L.r. 1.2684e-04
[2019-01-16 04:17:59] Ep. 3 : Up. 90000 : Sen. 34,365,744 : Cost 24.84359932 : Time 448.85s : 13786.23 words/s : L.r. 1.2649e-04
[2019-01-16 04:17:59] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 04:18:04] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter90000.npz
[2019-01-16 04:18:08] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 04:18:13] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 04:18:24] [valid] Ep. 3 : Up. 90000 : cross-entropy : 20.0467 : new best
[2019-01-16 04:18:27] [valid] Ep. 3 : Up. 90000 : perplexity : 4.73684 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 04:19:54] [valid] Ep. 3 : Up. 90000 : translation : 34.38 : new best
[2019-01-16 04:27:24] Ep. 3 : Up. 90500 : Sen. 35,017,310 : Cost 24.63846397 : Time 564.87s : 10918.56 words/s : L.r. 1.2614e-04
[2019-01-16 04:34:52] Ep. 3 : Up. 91000 : Sen. 35,667,253 : Cost 24.69753838 : Time 448.12s : 13771.43 words/s : L.r. 1.2579e-04
[2019-01-16 04:42:21] Ep. 3 : Up. 91500 : Sen. 36,321,629 : Cost 24.67816162 : Time 449.34s : 13804.68 words/s : L.r. 1.2545e-04
[2019-01-16 04:49:49] Ep. 3 : Up. 92000 : Sen. 36,970,572 : Cost 24.70914650 : Time 447.91s : 13753.88 words/s : L.r. 1.2511e-04
[2019-01-16 04:57:22] Ep. 3 : Up. 92500 : Sen. 37,632,000 : Cost 24.53068924 : Time 453.02s : 13774.97 words/s : L.r. 1.2477e-04
[2019-01-16 05:04:50] Ep. 3 : Up. 93000 : Sen. 38,278,967 : Cost 24.74168015 : Time 447.51s : 13745.82 words/s : L.r. 1.2443e-04
[2019-01-16 05:12:20] Ep. 3 : Up. 93500 : Sen. 38,935,623 : Cost 24.56928635 : Time 449.77s : 13808.39 words/s : L.r. 1.2410e-04
[2019-01-16 05:19:47] Ep. 3 : Up. 94000 : Sen. 39,586,442 : Cost 24.61351204 : Time 447.49s : 13764.98 words/s : L.r. 1.2377e-04
[2019-01-16 05:27:16] Ep. 3 : Up. 94500 : Sen. 40,238,479 : Cost 24.78383827 : Time 448.71s : 13843.37 words/s : L.r. 1.2344e-04
[2019-01-16 05:34:42] Ep. 3 : Up. 95000 : Sen. 40,893,057 : Cost 24.48036575 : Time 445.75s : 13830.99 words/s : L.r. 1.2312e-04
[2019-01-16 05:34:42] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 05:34:46] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter95000.npz
[2019-01-16 05:34:50] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 05:34:54] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 05:35:05] [valid] Ep. 3 : Up. 95000 : cross-entropy : 19.9669 : new best
[2019-01-16 05:35:08] [valid] Ep. 3 : Up. 95000 : perplexity : 4.7076 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 05:36:36] [valid] Ep. 3 : Up. 95000 : translation : 34.35 : stalled 1 times
[2019-01-16 05:44:09] Ep. 3 : Up. 95500 : Sen. 41,557,538 : Cost 24.59945869 : Time 566.88s : 11088.53 words/s : L.r. 1.2279e-04
[2019-01-16 05:46:15] Seen 41736931 samples
[2019-01-16 05:46:15] Starting epoch 4
[2019-01-16 05:46:15] [data] Shuffling files
[2019-01-16 05:46:30] [data] Done reading 41736982 sentences
[2019-01-16 05:50:16] [data] Done shuffling 41736982 sentences to temp files
[2019-01-16 05:55:41] Ep. 4 : Up. 96000 : Sen. 466,575 : Cost 24.59748077 : Time 692.25s : 8863.93 words/s : L.r. 1.2247e-04
[2019-01-16 06:03:10] Ep. 4 : Up. 96500 : Sen. 1,124,047 : Cost 24.60357475 : Time 449.63s : 13904.28 words/s : L.r. 1.2216e-04
[2019-01-16 06:10:36] Ep. 4 : Up. 97000 : Sen. 1,776,033 : Cost 24.45995903 : Time 445.63s : 13833.71 words/s : L.r. 1.2184e-04
[2019-01-16 06:18:02] Ep. 4 : Up. 97500 : Sen. 2,431,200 : Cost 24.51532364 : Time 445.47s : 13947.64 words/s : L.r. 1.2153e-04
[2019-01-16 06:25:28] Ep. 4 : Up. 98000 : Sen. 3,086,069 : Cost 24.50423431 : Time 446.17s : 13898.76 words/s : L.r. 1.2122e-04
[2019-01-16 06:32:54] Ep. 4 : Up. 98500 : Sen. 3,746,899 : Cost 24.37141991 : Time 446.75s : 13943.16 words/s : L.r. 1.2091e-04
[2019-01-16 06:40:20] Ep. 4 : Up. 99000 : Sen. 4,392,567 : Cost 24.85348892 : Time 445.26s : 13914.33 words/s : L.r. 1.2060e-04
[2019-01-16 06:47:48] Ep. 4 : Up. 99500 : Sen. 5,056,800 : Cost 24.32949066 : Time 448.71s : 13934.55 words/s : L.r. 1.2030e-04
[2019-01-16 06:55:13] Ep. 4 : Up. 100000 : Sen. 5,710,942 : Cost 24.47451782 : Time 444.72s : 13920.68 words/s : L.r. 1.2000e-04
[2019-01-16 06:55:13] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 06:55:18] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter100000.npz
[2019-01-16 06:55:21] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 06:55:26] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 06:55:41] [valid] Ep. 4 : Up. 100000 : cross-entropy : 19.8978 : new best
[2019-01-16 06:55:44] [valid] Ep. 4 : Up. 100000 : perplexity : 4.68243 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 06:57:14] [valid] Ep. 4 : Up. 100000 : translation : 34.37 : stalled 2 times
[2019-01-16 07:04:42] Ep. 4 : Up. 100500 : Sen. 6,369,860 : Cost 24.45567131 : Time 569.02s : 10951.22 words/s : L.r. 1.1970e-04
[2019-01-16 07:12:08] Ep. 4 : Up. 101000 : Sen. 7,018,667 : Cost 24.83522224 : Time 446.05s : 13942.49 words/s : L.r. 1.1940e-04
[2019-01-16 07:19:31] Ep. 4 : Up. 101500 : Sen. 7,674,680 : Cost 24.42374229 : Time 442.96s : 13988.74 words/s : L.r. 1.1911e-04
[2019-01-16 07:26:56] Ep. 4 : Up. 102000 : Sen. 8,331,897 : Cost 24.33519936 : Time 444.44s : 13924.09 words/s : L.r. 1.1882e-04
[2019-01-16 07:34:20] Ep. 4 : Up. 102500 : Sen. 8,982,602 : Cost 24.57433128 : Time 443.91s : 13918.52 words/s : L.r. 1.1853e-04
[2019-01-16 07:41:44] Ep. 4 : Up. 103000 : Sen. 9,638,319 : Cost 24.55958366 : Time 444.63s : 13989.54 words/s : L.r. 1.1824e-04
[2019-01-16 07:49:08] Ep. 4 : Up. 103500 : Sen. 10,291,400 : Cost 24.61169052 : Time 444.09s : 13990.57 words/s : L.r. 1.1795e-04
[2019-01-16 07:56:32] Ep. 4 : Up. 104000 : Sen. 10,945,736 : Cost 24.44957733 : Time 443.77s : 13960.18 words/s : L.r. 1.1767e-04
[2019-01-16 08:03:54] Ep. 4 : Up. 104500 : Sen. 11,599,236 : Cost 24.40666962 : Time 441.94s : 13963.63 words/s : L.r. 1.1739e-04
[2019-01-16 08:11:20] Ep. 4 : Up. 105000 : Sen. 12,258,668 : Cost 24.45068550 : Time 445.91s : 13996.61 words/s : L.r. 1.1711e-04
[2019-01-16 08:11:20] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 08:11:24] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter105000.npz
[2019-01-16 08:11:28] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 08:11:32] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 08:11:44] [valid] Ep. 4 : Up. 105000 : cross-entropy : 19.8352 : new best
[2019-01-16 08:11:46] [valid] Ep. 4 : Up. 105000 : perplexity : 4.65976 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 08:13:13] [valid] Ep. 4 : Up. 105000 : translation : 34.47 : new best
[2019-01-16 08:20:37] Ep. 4 : Up. 105500 : Sen. 12,915,741 : Cost 24.56187820 : Time 556.74s : 11207.64 words/s : L.r. 1.1683e-04
[2019-01-16 08:27:56] Ep. 4 : Up. 106000 : Sen. 13,567,344 : Cost 24.43308258 : Time 439.72s : 14021.72 words/s : L.r. 1.1655e-04
[2019-01-16 08:35:21] Ep. 4 : Up. 106500 : Sen. 14,223,515 : Cost 24.52340698 : Time 444.62s : 13998.86 words/s : L.r. 1.1628e-04
[2019-01-16 08:42:43] Ep. 4 : Up. 107000 : Sen. 14,876,603 : Cost 24.47714615 : Time 441.70s : 14008.02 words/s : L.r. 1.1601e-04
[2019-01-16 08:50:08] Ep. 4 : Up. 107500 : Sen. 15,536,319 : Cost 24.54816055 : Time 445.49s : 14059.90 words/s : L.r. 1.1574e-04
[2019-01-16 08:57:29] Ep. 4 : Up. 108000 : Sen. 16,191,344 : Cost 24.44953728 : Time 440.88s : 14057.44 words/s : L.r. 1.1547e-04
[2019-01-16 09:04:51] Ep. 4 : Up. 108500 : Sen. 16,850,608 : Cost 24.37042618 : Time 442.20s : 14076.66 words/s : L.r. 1.1520e-04
[2019-01-16 09:12:12] Ep. 4 : Up. 109000 : Sen. 17,501,467 : Cost 24.38363075 : Time 440.53s : 13959.98 words/s : L.r. 1.1494e-04
[2019-01-16 09:19:36] Ep. 4 : Up. 109500 : Sen. 18,151,372 : Cost 24.63657951 : Time 444.00s : 13958.30 words/s : L.r. 1.1468e-04
[2019-01-16 09:26:57] Ep. 4 : Up. 110000 : Sen. 18,799,315 : Cost 24.44878387 : Time 440.79s : 13914.00 words/s : L.r. 1.1442e-04
[2019-01-16 09:26:57] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 09:27:01] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter110000.npz
[2019-01-16 09:27:05] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 09:27:09] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 09:27:20] [valid] Ep. 4 : Up. 110000 : cross-entropy : 19.7845 : new best
[2019-01-16 09:27:23] [valid] Ep. 4 : Up. 110000 : perplexity : 4.64145 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 09:28:53] [valid] Ep. 4 : Up. 110000 : translation : 34.53 : new best
[2019-01-16 09:36:18] Ep. 4 : Up. 110500 : Sen. 19,457,420 : Cost 24.38816071 : Time 561.12s : 11077.66 words/s : L.r. 1.1416e-04
[2019-01-16 09:43:47] Ep. 4 : Up. 111000 : Sen. 20,120,365 : Cost 24.56958199 : Time 449.77s : 14030.62 words/s : L.r. 1.1390e-04
[2019-01-16 09:51:08] Ep. 4 : Up. 111500 : Sen. 20,775,910 : Cost 24.11146736 : Time 440.76s : 13912.23 words/s : L.r. 1.1364e-04
[2019-01-16 09:58:33] Ep. 4 : Up. 112000 : Sen. 21,426,084 : Cost 24.70940971 : Time 445.09s : 13970.93 words/s : L.r. 1.1339e-04
[2019-01-16 10:05:56] Ep. 4 : Up. 112500 : Sen. 22,080,000 : Cost 24.46980476 : Time 442.92s : 13994.88 words/s : L.r. 1.1314e-04
[2019-01-16 10:13:23] Ep. 4 : Up. 113000 : Sen. 22,734,332 : Cost 24.57428551 : Time 446.61s : 13942.84 words/s : L.r. 1.1289e-04
[2019-01-16 10:20:48] Ep. 4 : Up. 113500 : Sen. 23,389,467 : Cost 24.38679886 : Time 445.04s : 13915.20 words/s : L.r. 1.1264e-04
[2019-01-16 10:28:12] Ep. 4 : Up. 114000 : Sen. 24,041,166 : Cost 24.35369301 : Time 444.22s : 13859.72 words/s : L.r. 1.1239e-04
[2019-01-16 10:35:39] Ep. 4 : Up. 114500 : Sen. 24,696,759 : Cost 24.51194191 : Time 447.15s : 13935.07 words/s : L.r. 1.1214e-04
[2019-01-16 10:43:07] Ep. 4 : Up. 115000 : Sen. 25,355,586 : Cost 24.49571419 : Time 447.80s : 13973.97 words/s : L.r. 1.1190e-04
[2019-01-16 10:43:07] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 10:43:11] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter115000.npz
[2019-01-16 10:43:15] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 10:43:21] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 10:43:32] [valid] Ep. 4 : Up. 115000 : cross-entropy : 19.744 : new best
[2019-01-16 10:43:34] [valid] Ep. 4 : Up. 115000 : perplexity : 4.6269 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 10:44:59] [valid] Ep. 4 : Up. 115000 : translation : 34.46 : stalled 1 times
[2019-01-16 10:52:24] Ep. 4 : Up. 115500 : Sen. 26,008,076 : Cost 24.48864174 : Time 557.40s : 11116.20 words/s : L.r. 1.1166e-04
[2019-01-16 10:59:54] Ep. 4 : Up. 116000 : Sen. 26,672,019 : Cost 24.13181877 : Time 449.54s : 13860.56 words/s : L.r. 1.1142e-04
[2019-01-16 11:07:20] Ep. 4 : Up. 116500 : Sen. 27,321,721 : Cost 24.58339882 : Time 445.88s : 13864.83 words/s : L.r. 1.1118e-04
[2019-01-16 11:14:47] Ep. 4 : Up. 117000 : Sen. 27,976,349 : Cost 24.38401413 : Time 446.66s : 13865.07 words/s : L.r. 1.1094e-04
[2019-01-16 11:22:12] Ep. 4 : Up. 117500 : Sen. 28,627,936 : Cost 24.41730499 : Time 445.04s : 13877.74 words/s : L.r. 1.1070e-04
[2019-01-16 11:29:35] Ep. 4 : Up. 118000 : Sen. 29,275,959 : Cost 24.36281586 : Time 443.27s : 13820.81 words/s : L.r. 1.1047e-04
[2019-01-16 11:37:01] Ep. 4 : Up. 118500 : Sen. 29,923,928 : Cost 24.56317520 : Time 445.86s : 13836.76 words/s : L.r. 1.1024e-04
[2019-01-16 11:44:30] Ep. 4 : Up. 119000 : Sen. 30,580,677 : Cost 24.45363045 : Time 449.21s : 13873.61 words/s : L.r. 1.1000e-04
[2019-01-16 11:51:59] Ep. 4 : Up. 119500 : Sen. 31,236,605 : Cost 24.33279037 : Time 448.79s : 13803.56 words/s : L.r. 1.0977e-04
[2019-01-16 11:59:28] Ep. 4 : Up. 120000 : Sen. 31,897,868 : Cost 24.28830528 : Time 449.63s : 13874.13 words/s : L.r. 1.0954e-04
[2019-01-16 11:59:28] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 11:59:33] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter120000.npz
[2019-01-16 11:59:37] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 11:59:41] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 11:59:53] [valid] Ep. 4 : Up. 120000 : cross-entropy : 19.6938 : new best
[2019-01-16 11:59:56] [valid] Ep. 4 : Up. 120000 : perplexity : 4.60889 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 12:01:20] [valid] Ep. 4 : Up. 120000 : translation : 34.43 : stalled 2 times
[2019-01-16 12:08:48] Ep. 4 : Up. 120500 : Sen. 32,543,543 : Cost 24.59228134 : Time 559.25s : 11009.86 words/s : L.r. 1.0932e-04
[2019-01-16 12:16:18] Ep. 4 : Up. 121000 : Sen. 33,204,281 : Cost 24.40969086 : Time 450.11s : 13910.62 words/s : L.r. 1.0909e-04
[2019-01-16 12:23:49] Ep. 4 : Up. 121500 : Sen. 33,860,378 : Cost 24.53244781 : Time 451.45s : 13844.08 words/s : L.r. 1.0887e-04
[2019-01-16 12:31:21] Ep. 4 : Up. 122000 : Sen. 34,520,369 : Cost 24.29875946 : Time 451.43s : 13812.48 words/s : L.r. 1.0864e-04
[2019-01-16 12:38:52] Ep. 4 : Up. 122500 : Sen. 35,183,541 : Cost 24.22261429 : Time 451.14s : 13838.82 words/s : L.r. 1.0842e-04
[2019-01-16 12:46:22] Ep. 4 : Up. 123000 : Sen. 35,837,411 : Cost 24.50848007 : Time 450.79s : 13801.20 words/s : L.r. 1.0820e-04
[2019-01-16 12:53:54] Ep. 4 : Up. 123500 : Sen. 36,496,851 : Cost 24.29928970 : Time 451.40s : 13790.87 words/s : L.r. 1.0798e-04
[2019-01-16 13:01:20] Ep. 4 : Up. 124000 : Sen. 37,145,129 : Cost 24.36643600 : Time 445.79s : 13769.10 words/s : L.r. 1.0776e-04
[2019-01-16 13:08:54] Ep. 4 : Up. 124500 : Sen. 37,805,385 : Cost 24.58239365 : Time 454.67s : 13857.53 words/s : L.r. 1.0755e-04
[2019-01-16 13:16:25] Ep. 4 : Up. 125000 : Sen. 38,457,973 : Cost 24.41051483 : Time 450.77s : 13728.94 words/s : L.r. 1.0733e-04
[2019-01-16 13:16:25] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 13:16:29] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter125000.npz
[2019-01-16 13:16:33] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 13:16:38] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 13:16:49] [valid] Ep. 4 : Up. 125000 : cross-entropy : 19.6406 : new best
[2019-01-16 13:16:52] [valid] Ep. 4 : Up. 125000 : perplexity : 4.58994 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 13:18:20] [valid] Ep. 4 : Up. 125000 : translation : 34.46 : stalled 3 times
[2019-01-16 13:25:48] Ep. 4 : Up. 125500 : Sen. 39,109,176 : Cost 24.25303268 : Time 563.30s : 10905.83 words/s : L.r. 1.0712e-04
[2019-01-16 13:33:22] Ep. 4 : Up. 126000 : Sen. 39,762,850 : Cost 24.58039665 : Time 454.05s : 13743.22 words/s : L.r. 1.0690e-04
[2019-01-16 13:40:53] Ep. 4 : Up. 126500 : Sen. 40,423,534 : Cost 24.05792236 : Time 450.22s : 13738.81 words/s : L.r. 1.0669e-04
[2019-01-16 13:48:24] Ep. 4 : Up. 127000 : Sen. 41,075,758 : Cost 24.44990730 : Time 451.68s : 13724.66 words/s : L.r. 1.0648e-04
[2019-01-16 13:55:53] Ep. 4 : Up. 127500 : Sen. 41,724,135 : Cost 24.44818306 : Time 449.11s : 13720.72 words/s : L.r. 1.0627e-04
[2019-01-16 13:56:04] Seen 41736931 samples
[2019-01-16 13:56:04] Starting epoch 5
[2019-01-16 13:56:04] [data] Shuffling files
[2019-01-16 13:56:20] [data] Done reading 41736982 sentences
[2019-01-16 14:00:03] [data] Done shuffling 41736982 sentences to temp files
[2019-01-16 14:07:29] Ep. 5 : Up. 128000 : Sen. 640,000 : Cost 24.25096893 : Time 695.80s : 8890.08 words/s : L.r. 1.0607e-04
[2019-01-16 14:14:58] Ep. 5 : Up. 128500 : Sen. 1,290,414 : Cost 24.21859550 : Time 448.45s : 13717.79 words/s : L.r. 1.0586e-04
[2019-01-16 14:22:33] Ep. 5 : Up. 129000 : Sen. 1,950,314 : Cost 24.26954079 : Time 454.90s : 13750.86 words/s : L.r. 1.0565e-04
[2019-01-16 14:30:04] Ep. 5 : Up. 129500 : Sen. 2,601,557 : Cost 24.41994286 : Time 451.57s : 13723.82 words/s : L.r. 1.0545e-04
[2019-01-16 14:37:33] Ep. 5 : Up. 130000 : Sen. 3,254,819 : Cost 24.18266106 : Time 449.13s : 13742.98 words/s : L.r. 1.0525e-04
[2019-01-16 14:37:33] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 14:37:38] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter130000.npz
[2019-01-16 14:37:41] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 14:37:46] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 14:37:57] [valid] Ep. 5 : Up. 130000 : cross-entropy : 19.5899 : new best
[2019-01-16 14:38:00] [valid] Ep. 5 : Up. 130000 : perplexity : 4.5719 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 14:39:25] [valid] Ep. 5 : Up. 130000 : translation : 34.5 : stalled 4 times
[2019-01-16 14:46:54] Ep. 5 : Up. 130500 : Sen. 3,904,800 : Cost 24.31037140 : Time 560.70s : 11002.06 words/s : L.r. 1.0505e-04
[2019-01-16 14:54:26] Ep. 5 : Up. 131000 : Sen. 4,560,727 : Cost 24.16205978 : Time 452.03s : 13703.76 words/s : L.r. 1.0484e-04
[2019-01-16 15:02:00] Ep. 5 : Up. 131500 : Sen. 5,219,380 : Cost 24.20135117 : Time 453.47s : 13723.04 words/s : L.r. 1.0464e-04
[2019-01-16 15:09:32] Ep. 5 : Up. 132000 : Sen. 5,872,910 : Cost 24.36560631 : Time 452.13s : 13746.41 words/s : L.r. 1.0445e-04
[2019-01-16 15:17:02] Ep. 5 : Up. 132500 : Sen. 6,526,880 : Cost 24.23924828 : Time 450.10s : 13752.17 words/s : L.r. 1.0425e-04
[2019-01-16 15:24:31] Ep. 5 : Up. 133000 : Sen. 7,174,173 : Cost 24.46372223 : Time 448.86s : 13749.57 words/s : L.r. 1.0405e-04
[2019-01-16 15:32:05] Ep. 5 : Up. 133500 : Sen. 7,832,517 : Cost 24.31646919 : Time 454.16s : 13750.66 words/s : L.r. 1.0386e-04
[2019-01-16 15:39:33] Ep. 5 : Up. 134000 : Sen. 8,481,504 : Cost 24.34689522 : Time 448.21s : 13750.08 words/s : L.r. 1.0366e-04
[2019-01-16 15:47:06] Ep. 5 : Up. 134500 : Sen. 9,146,675 : Cost 23.99683762 : Time 453.05s : 13768.57 words/s : L.r. 1.0347e-04
[2019-01-16 15:54:37] Ep. 5 : Up. 135000 : Sen. 9,799,582 : Cost 24.42377472 : Time 450.80s : 13810.24 words/s : L.r. 1.0328e-04
[2019-01-16 15:54:37] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 15:54:41] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter135000.npz
[2019-01-16 15:54:45] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 15:54:49] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 15:55:01] [valid] Ep. 5 : Up. 135000 : cross-entropy : 19.5668 : new best
[2019-01-16 15:55:03] [valid] Ep. 5 : Up. 135000 : perplexity : 4.56374 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 15:56:28] [valid] Ep. 5 : Up. 135000 : translation : 34.55 : new best
[2019-01-16 16:03:58] Ep. 5 : Up. 135500 : Sen. 10,456,093 : Cost 23.99169731 : Time 561.17s : 10967.52 words/s : L.r. 1.0309e-04
[2019-01-16 16:11:28] Ep. 5 : Up. 136000 : Sen. 11,110,463 : Cost 24.39426041 : Time 449.86s : 13850.79 words/s : L.r. 1.0290e-04
[2019-01-16 16:18:54] Ep. 5 : Up. 136500 : Sen. 11,755,429 : Cost 24.36199951 : Time 445.75s : 13734.60 words/s : L.r. 1.0271e-04
[2019-01-16 16:26:24] Ep. 5 : Up. 137000 : Sen. 12,410,894 : Cost 24.28041077 : Time 450.06s : 13790.74 words/s : L.r. 1.0252e-04
[2019-01-16 16:33:51] Ep. 5 : Up. 137500 : Sen. 13,060,975 : Cost 24.25636673 : Time 446.88s : 13775.77 words/s : L.r. 1.0234e-04
[2019-01-16 16:41:20] Ep. 5 : Up. 138000 : Sen. 13,715,329 : Cost 24.35264587 : Time 449.85s : 13818.35 words/s : L.r. 1.0215e-04
[2019-01-16 16:48:48] Ep. 5 : Up. 138500 : Sen. 14,367,587 : Cost 24.26768875 : Time 447.38s : 13828.15 words/s : L.r. 1.0197e-04
[2019-01-16 16:56:21] Ep. 5 : Up. 139000 : Sen. 15,030,503 : Cost 24.27822113 : Time 453.14s : 13887.11 words/s : L.r. 1.0178e-04
[2019-01-16 17:03:49] Ep. 5 : Up. 139500 : Sen. 15,684,776 : Cost 24.16265488 : Time 448.23s : 13782.59 words/s : L.r. 1.0160e-04
[2019-01-16 17:11:19] Ep. 5 : Up. 140000 : Sen. 16,342,678 : Cost 24.31410789 : Time 449.61s : 13898.57 words/s : L.r. 1.0142e-04
[2019-01-16 17:11:19] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 17:11:23] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter140000.npz
[2019-01-16 17:11:27] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 17:11:31] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 17:11:43] [valid] Ep. 5 : Up. 140000 : cross-entropy : 19.5301 : new best
[2019-01-16 17:11:45] [valid] Ep. 5 : Up. 140000 : perplexity : 4.55075 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 17:13:10] [valid] Ep. 5 : Up. 140000 : translation : 34.41 : stalled 1 times
[2019-01-16 17:20:39] Ep. 5 : Up. 140500 : Sen. 17,000,798 : Cost 24.25113297 : Time 559.95s : 11132.58 words/s : L.r. 1.0124e-04
[2019-01-16 17:28:04] Ep. 5 : Up. 141000 : Sen. 17,655,804 : Cost 24.18040466 : Time 445.44s : 13885.14 words/s : L.r. 1.0106e-04
[2019-01-16 17:35:28] Ep. 5 : Up. 141500 : Sen. 18,303,416 : Cost 24.27285957 : Time 443.82s : 13834.76 words/s : L.r. 1.0088e-04
[2019-01-16 17:42:52] Ep. 5 : Up. 142000 : Sen. 18,953,978 : Cost 24.28513718 : Time 443.88s : 13897.29 words/s : L.r. 1.0070e-04
[2019-01-16 17:50:19] Ep. 5 : Up. 142500 : Sen. 19,606,484 : Cost 24.35938644 : Time 447.06s : 13870.71 words/s : L.r. 1.0052e-04
[2019-01-16 17:57:47] Ep. 5 : Up. 143000 : Sen. 20,261,398 : Cost 24.22019005 : Time 448.17s : 13829.74 words/s : L.r. 1.0035e-04
[2019-01-16 18:05:17] Ep. 5 : Up. 143500 : Sen. 20,918,985 : Cost 24.26044273 : Time 449.49s : 13874.63 words/s : L.r. 1.0017e-04
[2019-01-16 18:12:40] Ep. 5 : Up. 144000 : Sen. 21,572,888 : Cost 24.12664413 : Time 443.79s : 13885.52 words/s : L.r. 1.0000e-04
[2019-01-16 18:20:08] Ep. 5 : Up. 144500 : Sen. 22,227,796 : Cost 24.37949753 : Time 447.84s : 13928.54 words/s : L.r. 9.9827e-05
[2019-01-16 18:27:37] Ep. 5 : Up. 145000 : Sen. 22,892,317 : Cost 24.23135185 : Time 448.56s : 14028.42 words/s : L.r. 9.9655e-05
[2019-01-16 18:27:37] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 18:27:41] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter145000.npz
[2019-01-16 18:27:45] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 18:27:49] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 18:28:00] [valid] Ep. 5 : Up. 145000 : cross-entropy : 19.4764 : new best
[2019-01-16 18:28:03] [valid] Ep. 5 : Up. 145000 : perplexity : 4.53184 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 18:29:27] [valid] Ep. 5 : Up. 145000 : translation : 34.58 : new best
[2019-01-16 18:36:54] Ep. 5 : Up. 145500 : Sen. 23,548,036 : Cost 24.18149948 : Time 557.35s : 11116.72 words/s : L.r. 9.9483e-05
[2019-01-16 18:44:19] Ep. 5 : Up. 146000 : Sen. 24,202,527 : Cost 24.33678818 : Time 444.99s : 13982.54 words/s : L.r. 9.9313e-05
[2019-01-16 18:51:47] Ep. 5 : Up. 146500 : Sen. 24,860,872 : Cost 24.18646812 : Time 448.04s : 13884.59 words/s : L.r. 9.9143e-05
[2019-01-16 18:59:16] Ep. 5 : Up. 147000 : Sen. 25,525,495 : Cost 24.19056892 : Time 448.92s : 13993.49 words/s : L.r. 9.8974e-05
[2019-01-16 19:06:39] Ep. 5 : Up. 147500 : Sen. 26,172,662 : Cost 24.34715652 : Time 442.90s : 13898.06 words/s : L.r. 9.8806e-05
[2019-01-16 19:14:03] Ep. 5 : Up. 148000 : Sen. 26,830,466 : Cost 24.08323097 : Time 444.21s : 13941.92 words/s : L.r. 9.8639e-05
[2019-01-16 19:21:26] Ep. 5 : Up. 148500 : Sen. 27,479,534 : Cost 24.36569595 : Time 442.47s : 13967.46 words/s : L.r. 9.8473e-05
[2019-01-16 19:28:49] Ep. 5 : Up. 149000 : Sen. 28,134,179 : Cost 24.26235962 : Time 443.78s : 13981.42 words/s : L.r. 9.8308e-05
[2019-01-16 19:36:10] Ep. 5 : Up. 149500 : Sen. 28,785,027 : Cost 24.25501442 : Time 440.90s : 14003.11 words/s : L.r. 9.8143e-05
[2019-01-16 19:43:34] Ep. 5 : Up. 150000 : Sen. 29,440,000 : Cost 24.19234657 : Time 443.44s : 13973.53 words/s : L.r. 9.7980e-05
[2019-01-16 19:43:34] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 19:43:38] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter150000.npz
[2019-01-16 19:43:42] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 19:43:46] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 19:43:57] [valid] Ep. 5 : Up. 150000 : cross-entropy : 19.4414 : new best
[2019-01-16 19:44:00] [valid] Ep. 5 : Up. 150000 : perplexity : 4.51954 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 19:45:29] [valid] Ep. 5 : Up. 150000 : translation : 34.61 : new best
[2019-01-16 19:52:52] Ep. 5 : Up. 150500 : Sen. 30,089,758 : Cost 24.42247200 : Time 558.54s : 11088.56 words/s : L.r. 9.7817e-05
[2019-01-16 20:00:19] Ep. 5 : Up. 151000 : Sen. 30,753,207 : Cost 24.13389397 : Time 446.41s : 14021.88 words/s : L.r. 9.7655e-05
[2019-01-16 20:07:40] Ep. 5 : Up. 151500 : Sen. 31,405,803 : Cost 24.14600372 : Time 441.09s : 13972.08 words/s : L.r. 9.7493e-05
[2019-01-16 20:15:06] Ep. 5 : Up. 152000 : Sen. 32,062,322 : Cost 24.25954437 : Time 445.86s : 13972.44 words/s : L.r. 9.7333e-05
[2019-01-16 20:22:30] Ep. 5 : Up. 152500 : Sen. 32,715,354 : Cost 24.27509308 : Time 443.91s : 13958.45 words/s : L.r. 9.7173e-05
[2019-01-16 20:29:54] Ep. 5 : Up. 153000 : Sen. 33,369,074 : Cost 24.30459595 : Time 444.81s : 13961.92 words/s : L.r. 9.7014e-05
[2019-01-16 20:37:18] Ep. 5 : Up. 153500 : Sen. 34,025,352 : Cost 24.10630417 : Time 443.94s : 13951.75 words/s : L.r. 9.6856e-05
[2019-01-16 20:44:45] Ep. 5 : Up. 154000 : Sen. 34,681,343 : Cost 24.31025696 : Time 446.55s : 13964.09 words/s : L.r. 9.6699e-05
[2019-01-16 20:52:11] Ep. 5 : Up. 154500 : Sen. 35,336,882 : Cost 24.18838310 : Time 446.35s : 13902.79 words/s : L.r. 9.6542e-05
[2019-01-16 20:59:37] Ep. 5 : Up. 155000 : Sen. 35,993,275 : Cost 24.19885063 : Time 446.20s : 13931.86 words/s : L.r. 9.6386e-05
[2019-01-16 20:59:37] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 20:59:42] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter155000.npz
[2019-01-16 20:59:46] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 20:59:51] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 21:00:02] [valid] Ep. 5 : Up. 155000 : cross-entropy : 19.408 : new best
[2019-01-16 21:00:05] [valid] Ep. 5 : Up. 155000 : perplexity : 4.50784 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 21:01:30] [valid] Ep. 5 : Up. 155000 : translation : 34.64 : new best
[2019-01-16 21:08:55] Ep. 5 : Up. 155500 : Sen. 36,643,468 : Cost 24.37699699 : Time 557.80s : 11114.09 words/s : L.r. 9.6231e-05
[2019-01-16 21:16:18] Ep. 5 : Up. 156000 : Sen. 37,293,888 : Cost 24.21701813 : Time 442.81s : 13909.01 words/s : L.r. 9.6077e-05
[2019-01-16 21:23:42] Ep. 5 : Up. 156500 : Sen. 37,946,992 : Cost 24.10915375 : Time 443.50s : 13895.37 words/s : L.r. 9.5923e-05
[2019-01-16 21:31:10] Ep. 5 : Up. 157000 : Sen. 38,601,418 : Cost 24.41446304 : Time 448.02s : 13934.56 words/s : L.r. 9.5770e-05
[2019-01-16 21:38:32] Ep. 5 : Up. 157500 : Sen. 39,247,628 : Cost 24.25696373 : Time 442.17s : 13856.09 words/s : L.r. 9.5618e-05
[2019-01-16 21:46:02] Ep. 5 : Up. 158000 : Sen. 39,916,569 : Cost 23.95196915 : Time 450.19s : 13947.98 words/s : L.r. 9.5467e-05
[2019-01-16 21:53:28] Ep. 5 : Up. 158500 : Sen. 40,566,217 : Cost 24.34904099 : Time 446.54s : 13865.05 words/s : L.r. 9.5316e-05
[2019-01-16 22:00:57] Ep. 5 : Up. 159000 : Sen. 41,222,079 : Cost 24.43140411 : Time 448.77s : 13966.24 words/s : L.r. 9.5166e-05
[2019-01-16 22:06:49] Seen 41736931 samples
[2019-01-16 22:06:49] Starting epoch 6
[2019-01-16 22:06:49] [data] Shuffling files
[2019-01-16 22:07:04] [data] Done reading 41736982 sentences
[2019-01-16 22:10:46] [data] Done shuffling 41736982 sentences to temp files
[2019-01-16 22:12:28] Ep. 6 : Up. 159500 : Sen. 139,531 : Cost 23.95617294 : Time 690.31s : 8905.38 words/s : L.r. 9.5017e-05
[2019-01-16 22:19:52] Ep. 6 : Up. 160000 : Sen. 782,069 : Cost 24.27231598 : Time 444.40s : 13781.03 words/s : L.r. 9.4868e-05
[2019-01-16 22:19:52] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 22:19:56] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter160000.npz
[2019-01-16 22:19:59] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 22:20:04] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 22:20:15] [valid] Ep. 6 : Up. 160000 : cross-entropy : 19.3727 : new best
[2019-01-16 22:20:18] [valid] Ep. 6 : Up. 160000 : perplexity : 4.49551 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 22:21:42] [valid] Ep. 6 : Up. 160000 : translation : 34.66 : new best
[2019-01-16 22:29:15] Ep. 6 : Up. 160500 : Sen. 1,449,272 : Cost 23.89395714 : Time 562.58s : 11150.20 words/s : L.r. 9.4720e-05
[2019-01-16 22:36:44] Ep. 6 : Up. 161000 : Sen. 2,105,024 : Cost 24.25167274 : Time 449.52s : 13894.33 words/s : L.r. 9.4573e-05
[2019-01-16 22:44:13] Ep. 6 : Up. 161500 : Sen. 2,762,653 : Cost 23.98866463 : Time 448.82s : 13828.37 words/s : L.r. 9.4427e-05
[2019-01-16 22:51:45] Ep. 6 : Up. 162000 : Sen. 3,418,821 : Cost 24.24559784 : Time 451.94s : 13825.59 words/s : L.r. 9.4281e-05
[2019-01-16 22:59:13] Ep. 6 : Up. 162500 : Sen. 4,070,484 : Cost 24.08033562 : Time 447.76s : 13760.38 words/s : L.r. 9.4136e-05
[2019-01-16 23:06:43] Ep. 6 : Up. 163000 : Sen. 4,723,768 : Cost 24.18533516 : Time 450.17s : 13784.32 words/s : L.r. 9.3991e-05
[2019-01-16 23:14:11] Ep. 6 : Up. 163500 : Sen. 5,376,000 : Cost 24.11567116 : Time 448.27s : 13778.56 words/s : L.r. 9.3847e-05
[2019-01-16 23:21:42] Ep. 6 : Up. 164000 : Sen. 6,032,500 : Cost 24.10376167 : Time 451.11s : 13796.01 words/s : L.r. 9.3704e-05
[2019-01-16 23:29:10] Ep. 6 : Up. 164500 : Sen. 6,683,864 : Cost 24.03511238 : Time 448.22s : 13715.01 words/s : L.r. 9.3562e-05
[2019-01-16 23:36:41] Ep. 6 : Up. 165000 : Sen. 7,339,203 : Cost 24.23153877 : Time 451.08s : 13831.15 words/s : L.r. 9.3420e-05
[2019-01-16 23:36:41] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-16 23:36:46] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter165000.npz
[2019-01-16 23:36:49] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-16 23:36:54] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-16 23:37:05] [valid] Ep. 6 : Up. 165000 : cross-entropy : 19.3555 : new best
[2019-01-16 23:37:08] [valid] Ep. 6 : Up. 165000 : perplexity : 4.4895 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-16 23:38:32] [valid] Ep. 6 : Up. 165000 : translation : 34.64 : stalled 1 times
[2019-01-16 23:46:05] Ep. 6 : Up. 165500 : Sen. 7,998,219 : Cost 24.09229851 : Time 563.32s : 11071.48 words/s : L.r. 9.3279e-05
[2019-01-16 23:53:34] Ep. 6 : Up. 166000 : Sen. 8,649,957 : Cost 24.16935349 : Time 448.97s : 13783.74 words/s : L.r. 9.3138e-05
[2019-01-17 00:01:07] Ep. 6 : Up. 166500 : Sen. 9,310,762 : Cost 24.20535851 : Time 453.69s : 13829.13 words/s : L.r. 9.2998e-05
[2019-01-17 00:08:37] Ep. 6 : Up. 167000 : Sen. 9,965,422 : Cost 23.99825287 : Time 449.54s : 13734.52 words/s : L.r. 9.2859e-05
[2019-01-17 00:16:08] Ep. 6 : Up. 167500 : Sen. 10,620,464 : Cost 24.16542816 : Time 451.00s : 13773.06 words/s : L.r. 9.2720e-05
[2019-01-17 00:23:39] Ep. 6 : Up. 168000 : Sen. 11,272,265 : Cost 24.22777748 : Time 450.87s : 13754.83 words/s : L.r. 9.2582e-05
[2019-01-17 00:31:10] Ep. 6 : Up. 168500 : Sen. 11,922,568 : Cost 24.29901886 : Time 450.95s : 13748.19 words/s : L.r. 9.2445e-05
[2019-01-17 00:38:41] Ep. 6 : Up. 169000 : Sen. 12,583,100 : Cost 23.74244118 : Time 451.13s : 13687.34 words/s : L.r. 9.2308e-05
[2019-01-17 00:46:08] Ep. 6 : Up. 169500 : Sen. 13,228,445 : Cost 24.30857468 : Time 447.53s : 13756.23 words/s : L.r. 9.2171e-05
[2019-01-17 00:53:36] Ep. 6 : Up. 170000 : Sen. 13,876,956 : Cost 23.98101616 : Time 447.52s : 13654.28 words/s : L.r. 9.2036e-05
[2019-01-17 00:53:36] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 00:53:41] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter170000.npz
[2019-01-17 00:53:44] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 00:53:49] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 00:54:00] [valid] Ep. 6 : Up. 170000 : cross-entropy : 19.3334 : new best
[2019-01-17 00:54:03] [valid] Ep. 6 : Up. 170000 : perplexity : 4.48184 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 00:55:28] [valid] Ep. 6 : Up. 170000 : translation : 34.66 : stalled 2 times
[2019-01-17 01:03:01] Ep. 6 : Up. 170500 : Sen. 14,530,952 : Cost 24.14610100 : Time 564.76s : 10978.17 words/s : L.r. 9.1901e-05
[2019-01-17 01:10:33] Ep. 6 : Up. 171000 : Sen. 15,186,668 : Cost 24.17788887 : Time 452.35s : 13749.38 words/s : L.r. 9.1766e-05
[2019-01-17 01:18:05] Ep. 6 : Up. 171500 : Sen. 15,841,388 : Cost 24.08140564 : Time 452.18s : 13702.95 words/s : L.r. 9.1632e-05
[2019-01-17 01:25:38] Ep. 6 : Up. 172000 : Sen. 16,495,535 : Cost 24.19955444 : Time 452.67s : 13739.78 words/s : L.r. 9.1499e-05
[2019-01-17 01:33:08] Ep. 6 : Up. 172500 : Sen. 17,147,331 : Cost 24.03684425 : Time 449.89s : 13685.02 words/s : L.r. 9.1366e-05
[2019-01-17 01:40:41] Ep. 6 : Up. 173000 : Sen. 17,801,840 : Cost 24.18797112 : Time 453.66s : 13693.47 words/s : L.r. 9.1234e-05
[2019-01-17 01:48:13] Ep. 6 : Up. 173500 : Sen. 18,457,131 : Cost 24.09593010 : Time 451.05s : 13747.50 words/s : L.r. 9.1103e-05
[2019-01-17 01:55:47] Ep. 6 : Up. 174000 : Sen. 19,115,924 : Cost 24.24212837 : Time 454.77s : 13769.87 words/s : L.r. 9.0972e-05
[2019-01-17 02:03:16] Ep. 6 : Up. 174500 : Sen. 19,766,907 : Cost 23.97646713 : Time 449.16s : 13662.81 words/s : L.r. 9.0841e-05
[2019-01-17 02:10:51] Ep. 6 : Up. 175000 : Sen. 20,428,176 : Cost 24.17788124 : Time 454.89s : 13805.30 words/s : L.r. 9.0711e-05
[2019-01-17 02:10:51] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 02:10:56] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter175000.npz
[2019-01-17 02:10:59] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 02:11:04] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 02:11:15] [valid] Ep. 6 : Up. 175000 : cross-entropy : 19.3187 : new best
[2019-01-17 02:11:17] [valid] Ep. 6 : Up. 175000 : perplexity : 4.47672 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 02:12:44] [valid] Ep. 6 : Up. 175000 : translation : 34.66 : stalled 3 times
[2019-01-17 02:20:15] Ep. 6 : Up. 175500 : Sen. 21,081,504 : Cost 24.23181152 : Time 563.28s : 11021.65 words/s : L.r. 9.0582e-05
[2019-01-17 02:27:45] Ep. 6 : Up. 176000 : Sen. 21,732,957 : Cost 24.20411110 : Time 450.16s : 13756.03 words/s : L.r. 9.0453e-05
[2019-01-17 02:35:18] Ep. 6 : Up. 176500 : Sen. 22,392,902 : Cost 24.05110359 : Time 453.37s : 13764.84 words/s : L.r. 9.0325e-05
[2019-01-17 02:42:46] Ep. 6 : Up. 177000 : Sen. 23,040,000 : Cost 24.15359116 : Time 448.15s : 13684.97 words/s : L.r. 9.0198e-05
[2019-01-17 02:50:18] Ep. 6 : Up. 177500 : Sen. 23,695,534 : Cost 24.11574173 : Time 451.29s : 13768.98 words/s : L.r. 9.0070e-05
[2019-01-17 02:57:49] Ep. 6 : Up. 178000 : Sen. 24,352,543 : Cost 24.04196358 : Time 451.61s : 13737.44 words/s : L.r. 8.9944e-05
[2019-01-17 03:05:22] Ep. 6 : Up. 178500 : Sen. 25,008,703 : Cost 24.20518303 : Time 452.59s : 13783.78 words/s : L.r. 8.9818e-05
[2019-01-17 03:12:50] Ep. 6 : Up. 179000 : Sen. 25,661,048 : Cost 24.07505226 : Time 447.84s : 13773.99 words/s : L.r. 8.9692e-05
[2019-01-17 03:20:18] Ep. 6 : Up. 179500 : Sen. 26,314,972 : Cost 24.10159111 : Time 448.59s : 13810.64 words/s : L.r. 8.9567e-05
[2019-01-17 03:27:47] Ep. 6 : Up. 180000 : Sen. 26,969,495 : Cost 24.12609100 : Time 448.38s : 13829.64 words/s : L.r. 8.9443e-05
[2019-01-17 03:27:47] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 03:27:51] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter180000.npz
[2019-01-17 03:27:55] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 03:27:59] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 03:28:10] [valid] Ep. 6 : Up. 180000 : cross-entropy : 19.3043 : new best
[2019-01-17 03:28:13] [valid] Ep. 6 : Up. 180000 : perplexity : 4.47172 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 03:29:35] [valid] Ep. 6 : Up. 180000 : translation : 34.73 : new best
[2019-01-17 03:37:07] Ep. 6 : Up. 180500 : Sen. 27,626,151 : Cost 24.20486450 : Time 560.72s : 11137.01 words/s : L.r. 8.9319e-05
[2019-01-17 03:44:33] Ep. 6 : Up. 181000 : Sen. 28,274,939 : Cost 23.97335243 : Time 445.44s : 13735.84 words/s : L.r. 8.9195e-05
[2019-01-17 03:52:05] Ep. 6 : Up. 181500 : Sen. 28,934,517 : Cost 24.15739059 : Time 452.17s : 13836.80 words/s : L.r. 8.9072e-05
[2019-01-17 03:59:33] Ep. 6 : Up. 182000 : Sen. 29,591,089 : Cost 24.11618614 : Time 447.83s : 13882.69 words/s : L.r. 8.8950e-05
[2019-01-17 04:07:00] Ep. 6 : Up. 182500 : Sen. 30,247,287 : Cost 24.04453278 : Time 447.48s : 13868.59 words/s : L.r. 8.8828e-05
[2019-01-17 04:14:30] Ep. 6 : Up. 183000 : Sen. 30,901,251 : Cost 24.19707870 : Time 449.38s : 13830.36 words/s : L.r. 8.8707e-05
[2019-01-17 04:21:58] Ep. 6 : Up. 183500 : Sen. 31,554,520 : Cost 24.14696884 : Time 447.88s : 13840.71 words/s : L.r. 8.8586e-05
[2019-01-17 04:29:23] Ep. 6 : Up. 184000 : Sen. 32,207,359 : Cost 24.06996346 : Time 445.80s : 13850.32 words/s : L.r. 8.8465e-05
[2019-01-17 04:36:55] Ep. 6 : Up. 184500 : Sen. 32,866,738 : Cost 24.28763199 : Time 451.82s : 13931.37 words/s : L.r. 8.8345e-05
[2019-01-17 04:44:19] Ep. 6 : Up. 185000 : Sen. 33,517,669 : Cost 23.91419792 : Time 444.02s : 13782.06 words/s : L.r. 8.8226e-05
[2019-01-17 04:44:19] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 04:44:24] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter185000.npz
[2019-01-17 04:44:27] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 04:44:32] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 04:44:43] [valid] Ep. 6 : Up. 185000 : cross-entropy : 19.2798 : new best
[2019-01-17 04:44:46] [valid] Ep. 6 : Up. 185000 : perplexity : 4.46325 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 04:46:11] [valid] Ep. 6 : Up. 185000 : translation : 34.66 : stalled 1 times
[2019-01-17 04:53:34] Ep. 6 : Up. 185500 : Sen. 34,168,018 : Cost 24.04478264 : Time 554.43s : 11091.99 words/s : L.r. 8.8107e-05
[2019-01-17 05:01:00] Ep. 6 : Up. 186000 : Sen. 34,822,584 : Cost 24.12885475 : Time 446.67s : 13892.00 words/s : L.r. 8.7988e-05
[2019-01-17 05:08:28] Ep. 6 : Up. 186500 : Sen. 35,476,406 : Cost 24.14436913 : Time 447.49s : 13853.73 words/s : L.r. 8.7870e-05
[2019-01-17 05:15:56] Ep. 6 : Up. 187000 : Sen. 36,133,484 : Cost 24.24985504 : Time 448.39s : 13965.12 words/s : L.r. 8.7753e-05
[2019-01-17 05:23:19] Ep. 6 : Up. 187500 : Sen. 36,785,945 : Cost 23.99919701 : Time 443.21s : 13882.19 words/s : L.r. 8.7636e-05
[2019-01-17 05:30:47] Ep. 6 : Up. 188000 : Sen. 37,442,520 : Cost 24.15518761 : Time 447.67s : 13918.68 words/s : L.r. 8.7519e-05
[2019-01-17 05:38:13] Ep. 6 : Up. 188500 : Sen. 38,104,828 : Cost 23.83396721 : Time 446.38s : 13910.22 words/s : L.r. 8.7403e-05
[2019-01-17 05:45:39] Ep. 6 : Up. 189000 : Sen. 38,751,196 : Cost 24.48834991 : Time 445.31s : 13946.40 words/s : L.r. 8.7287e-05
[2019-01-17 05:53:02] Ep. 6 : Up. 189500 : Sen. 39,408,222 : Cost 23.88491249 : Time 443.01s : 13944.04 words/s : L.r. 8.7172e-05
[2019-01-17 06:00:26] Ep. 6 : Up. 190000 : Sen. 40,063,200 : Cost 24.17144966 : Time 444.46s : 13997.34 words/s : L.r. 8.7057e-05
[2019-01-17 06:00:26] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 06:00:31] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter190000.npz
[2019-01-17 06:00:34] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 06:00:39] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 06:00:50] [valid] Ep. 6 : Up. 190000 : cross-entropy : 19.2406 : new best
[2019-01-17 06:00:53] [valid] Ep. 6 : Up. 190000 : perplexity : 4.44966 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 06:02:21] [valid] Ep. 6 : Up. 190000 : translation : 34.77 : new best
[2019-01-17 06:09:48] Ep. 6 : Up. 190500 : Sen. 40,718,850 : Cost 24.21102142 : Time 561.53s : 11109.68 words/s : L.r. 8.6943e-05
[2019-01-17 06:17:10] Ep. 6 : Up. 191000 : Sen. 41,370,657 : Cost 24.00257492 : Time 442.41s : 13910.82 words/s : L.r. 8.6829e-05
[2019-01-17 06:21:22] Seen 41736931 samples
[2019-01-17 06:21:22] Starting epoch 7
[2019-01-17 06:21:22] [data] Shuffling files
[2019-01-17 06:21:37] [data] Done reading 41736982 sentences
[2019-01-17 06:25:15] [data] Done shuffling 41736982 sentences to temp files
[2019-01-17 06:28:35] Ep. 7 : Up. 191500 : Sen. 283,470 : Cost 24.02664375 : Time 684.65s : 8984.65 words/s : L.r. 8.6716e-05
[2019-01-17 06:36:01] Ep. 7 : Up. 192000 : Sen. 940,854 : Cost 24.12215233 : Time 446.21s : 14034.02 words/s : L.r. 8.6603e-05
[2019-01-17 06:43:25] Ep. 7 : Up. 192500 : Sen. 1,597,600 : Cost 23.85511780 : Time 444.27s : 13942.27 words/s : L.r. 8.6490e-05
[2019-01-17 06:50:47] Ep. 7 : Up. 193000 : Sen. 2,245,169 : Cost 23.99238396 : Time 441.59s : 13898.65 words/s : L.r. 8.6378e-05
[2019-01-17 06:58:13] Ep. 7 : Up. 193500 : Sen. 2,903,828 : Cost 23.89014053 : Time 446.16s : 13913.64 words/s : L.r. 8.6266e-05
[2019-01-17 07:05:36] Ep. 7 : Up. 194000 : Sen. 3,555,453 : Cost 24.03397751 : Time 442.65s : 13957.72 words/s : L.r. 8.6155e-05
[2019-01-17 07:13:02] Ep. 7 : Up. 194500 : Sen. 4,215,592 : Cost 24.19518089 : Time 446.84s : 14086.48 words/s : L.r. 8.6044e-05
[2019-01-17 07:20:27] Ep. 7 : Up. 195000 : Sen. 4,866,632 : Cost 24.02575874 : Time 444.50s : 13875.43 words/s : L.r. 8.5934e-05
[2019-01-17 07:20:27] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 07:20:31] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter195000.npz
[2019-01-17 07:20:35] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 07:20:39] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 07:20:50] [valid] Ep. 7 : Up. 195000 : cross-entropy : 19.2088 : new best
[2019-01-17 07:20:53] [valid] Ep. 7 : Up. 195000 : perplexity : 4.4387 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 07:22:22] [valid] Ep. 7 : Up. 195000 : translation : 34.77 : stalled 1 times
[2019-01-17 07:29:46] Ep. 7 : Up. 195500 : Sen. 5,523,735 : Cost 23.83143044 : Time 559.37s : 11060.52 words/s : L.r. 8.5824e-05
[2019-01-17 07:37:11] Ep. 7 : Up. 196000 : Sen. 6,172,517 : Cost 24.19438553 : Time 444.22s : 13948.23 words/s : L.r. 8.5714e-05
[2019-01-17 07:44:36] Ep. 7 : Up. 196500 : Sen. 6,833,002 : Cost 23.81245232 : Time 445.38s : 13948.67 words/s : L.r. 8.5605e-05
[2019-01-17 07:52:03] Ep. 7 : Up. 197000 : Sen. 7,488,000 : Cost 24.08894920 : Time 447.07s : 13922.66 words/s : L.r. 8.5496e-05
[2019-01-17 07:59:27] Ep. 7 : Up. 197500 : Sen. 8,139,832 : Cost 23.94551468 : Time 443.70s : 13874.72 words/s : L.r. 8.5388e-05
[2019-01-17 08:06:52] Ep. 7 : Up. 198000 : Sen. 8,791,488 : Cost 24.11698914 : Time 445.41s : 13923.42 words/s : L.r. 8.5280e-05
[2019-01-17 08:14:17] Ep. 7 : Up. 198500 : Sen. 9,448,412 : Cost 23.93103981 : Time 445.24s : 13945.97 words/s : L.r. 8.5173e-05
[2019-01-17 08:21:45] Ep. 7 : Up. 199000 : Sen. 10,102,922 : Cost 24.15348816 : Time 447.50s : 13922.40 words/s : L.r. 8.5066e-05
[2019-01-17 08:29:12] Ep. 7 : Up. 199500 : Sen. 10,762,102 : Cost 23.80342102 : Time 447.04s : 13857.63 words/s : L.r. 8.4959e-05
[2019-01-17 08:36:42] Ep. 7 : Up. 200000 : Sen. 11,421,280 : Cost 24.16262436 : Time 450.32s : 13940.31 words/s : L.r. 8.4853e-05
[2019-01-17 08:36:42] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 08:36:47] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter200000.npz
[2019-01-17 08:36:50] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 08:36:55] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 08:37:06] [valid] Ep. 7 : Up. 200000 : cross-entropy : 19.1882 : new best
[2019-01-17 08:37:09] [valid] Ep. 7 : Up. 200000 : perplexity : 4.4316 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 08:38:35] [valid] Ep. 7 : Up. 200000 : translation : 34.62 : stalled 2 times
[2019-01-17 08:46:03] Ep. 7 : Up. 200500 : Sen. 12,070,533 : Cost 24.08121872 : Time 560.77s : 10996.64 words/s : L.r. 8.4747e-05
[2019-01-17 08:53:32] Ep. 7 : Up. 201000 : Sen. 12,729,001 : Cost 24.05244446 : Time 449.10s : 13907.88 words/s : L.r. 8.4641e-05
[2019-01-17 09:00:58] Ep. 7 : Up. 201500 : Sen. 13,381,328 : Cost 23.95877457 : Time 445.68s : 13832.91 words/s : L.r. 8.4536e-05
[2019-01-17 09:08:26] Ep. 7 : Up. 202000 : Sen. 14,034,449 : Cost 24.01958466 : Time 447.71s : 13824.79 words/s : L.r. 8.4432e-05
[2019-01-17 09:15:53] Ep. 7 : Up. 202500 : Sen. 14,685,035 : Cost 24.08504868 : Time 447.13s : 13821.53 words/s : L.r. 8.4327e-05
[2019-01-17 09:23:19] Ep. 7 : Up. 203000 : Sen. 15,339,218 : Cost 23.87464523 : Time 446.73s : 13793.29 words/s : L.r. 8.4223e-05
[2019-01-17 09:30:49] Ep. 7 : Up. 203500 : Sen. 15,991,022 : Cost 24.20874786 : Time 450.10s : 13816.54 words/s : L.r. 8.4120e-05
[2019-01-17 09:38:18] Ep. 7 : Up. 204000 : Sen. 16,642,952 : Cost 23.95287132 : Time 448.38s : 13733.17 words/s : L.r. 8.4017e-05
[2019-01-17 09:45:45] Ep. 7 : Up. 204500 : Sen. 17,293,546 : Cost 24.13970375 : Time 447.58s : 13836.99 words/s : L.r. 8.3914e-05
[2019-01-17 09:53:15] Ep. 7 : Up. 205000 : Sen. 17,952,510 : Cost 23.90036774 : Time 450.04s : 13803.74 words/s : L.r. 8.3812e-05
[2019-01-17 09:53:15] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 09:53:20] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter205000.npz
[2019-01-17 09:53:24] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 09:53:28] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 09:53:39] [valid] Ep. 7 : Up. 205000 : cross-entropy : 19.1637 : new best
[2019-01-17 09:53:42] [valid] Ep. 7 : Up. 205000 : perplexity : 4.42319 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 09:55:07] [valid] Ep. 7 : Up. 205000 : translation : 34.69 : stalled 3 times
[2019-01-17 10:02:37] Ep. 7 : Up. 205500 : Sen. 18,611,307 : Cost 23.85013962 : Time 561.11s : 11047.73 words/s : L.r. 8.3710e-05
[2019-01-17 10:10:06] Ep. 7 : Up. 206000 : Sen. 19,257,507 : Cost 24.36250305 : Time 449.76s : 13782.93 words/s : L.r. 8.3608e-05
[2019-01-17 10:17:37] Ep. 7 : Up. 206500 : Sen. 19,914,152 : Cost 23.83325958 : Time 450.20s : 13722.76 words/s : L.r. 8.3507e-05
[2019-01-17 10:25:08] Ep. 7 : Up. 207000 : Sen. 20,563,441 : Cost 24.34120560 : Time 451.27s : 13790.53 words/s : L.r. 8.3406e-05
[2019-01-17 10:32:40] Ep. 7 : Up. 207500 : Sen. 21,221,407 : Cost 24.00757408 : Time 452.41s : 13768.93 words/s : L.r. 8.3305e-05
[2019-01-17 10:40:11] Ep. 7 : Up. 208000 : Sen. 21,877,120 : Cost 23.94219017 : Time 451.03s : 13726.38 words/s : L.r. 8.3205e-05
[2019-01-17 10:47:42] Ep. 7 : Up. 208500 : Sen. 22,530,035 : Cost 24.05328178 : Time 450.97s : 13734.31 words/s : L.r. 8.3105e-05
[2019-01-17 10:55:14] Ep. 7 : Up. 209000 : Sen. 23,181,206 : Cost 24.10550117 : Time 451.97s : 13694.60 words/s : L.r. 8.3006e-05
[2019-01-17 11:02:45] Ep. 7 : Up. 209500 : Sen. 23,833,471 : Cost 24.00955009 : Time 451.21s : 13680.77 words/s : L.r. 8.2907e-05
[2019-01-17 11:10:17] Ep. 7 : Up. 210000 : Sen. 24,489,740 : Cost 23.88147163 : Time 451.30s : 13707.49 words/s : L.r. 8.2808e-05
[2019-01-17 11:10:17] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 11:10:21] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter210000.npz
[2019-01-17 11:10:25] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 11:10:29] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 11:10:40] [valid] Ep. 7 : Up. 210000 : cross-entropy : 19.1486 : new best
[2019-01-17 11:10:43] [valid] Ep. 7 : Up. 210000 : perplexity : 4.41801 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 11:12:08] [valid] Ep. 7 : Up. 210000 : translation : 34.73 : stalled 4 times
[2019-01-17 11:19:40] Ep. 7 : Up. 210500 : Sen. 25,138,470 : Cost 24.15638542 : Time 562.94s : 10980.29 words/s : L.r. 8.2709e-05
[2019-01-17 11:27:12] Ep. 7 : Up. 211000 : Sen. 25,795,400 : Cost 23.87554741 : Time 452.51s : 13684.75 words/s : L.r. 8.2611e-05
[2019-01-17 11:34:42] Ep. 7 : Up. 211500 : Sen. 26,440,150 : Cost 24.23538589 : Time 449.90s : 13699.42 words/s : L.r. 8.2514e-05
[2019-01-17 11:42:17] Ep. 7 : Up. 212000 : Sen. 27,103,687 : Cost 23.76824379 : Time 455.20s : 13683.57 words/s : L.r. 8.2416e-05
[2019-01-17 11:49:49] Ep. 7 : Up. 212500 : Sen. 27,755,704 : Cost 23.99907875 : Time 452.09s : 13651.42 words/s : L.r. 8.2319e-05
[2019-01-17 11:57:25] Ep. 7 : Up. 213000 : Sen. 28,411,564 : Cost 24.13243866 : Time 455.35s : 13714.11 words/s : L.r. 8.2223e-05
[2019-01-17 12:04:56] Ep. 7 : Up. 213500 : Sen. 29,065,612 : Cost 23.97578049 : Time 451.64s : 13707.63 words/s : L.r. 8.2126e-05
[2019-01-17 12:12:27] Ep. 7 : Up. 214000 : Sen. 29,719,213 : Cost 23.93338966 : Time 450.48s : 13706.92 words/s : L.r. 8.2030e-05
[2019-01-17 12:19:59] Ep. 7 : Up. 214500 : Sen. 30,369,019 : Cost 24.15987778 : Time 452.43s : 13683.95 words/s : L.r. 8.1935e-05
[2019-01-17 12:27:31] Ep. 7 : Up. 215000 : Sen. 31,023,566 : Cost 23.94034386 : Time 451.60s : 13702.16 words/s : L.r. 8.1839e-05
[2019-01-17 12:27:31] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 12:27:35] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter215000.npz
[2019-01-17 12:27:39] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 12:27:44] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 12:27:55] [valid] Ep. 7 : Up. 215000 : cross-entropy : 19.1334 : new best
[2019-01-17 12:27:58] [valid] Ep. 7 : Up. 215000 : perplexity : 4.41282 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 12:29:23] [valid] Ep. 7 : Up. 215000 : translation : 34.82 : new best
[2019-01-17 12:36:58] Ep. 7 : Up. 215500 : Sen. 31,680,000 : Cost 24.03454971 : Time 566.73s : 10983.00 words/s : L.r. 8.1744e-05
[2019-01-17 12:44:30] Ep. 7 : Up. 216000 : Sen. 32,334,156 : Cost 24.02877808 : Time 452.18s : 13714.27 words/s : L.r. 8.1650e-05
[2019-01-17 12:52:01] Ep. 7 : Up. 216500 : Sen. 32,986,565 : Cost 23.91727829 : Time 450.90s : 13657.55 words/s : L.r. 8.1555e-05
[2019-01-17 12:59:34] Ep. 7 : Up. 217000 : Sen. 33,638,260 : Cost 24.32609749 : Time 453.37s : 13786.39 words/s : L.r. 8.1461e-05
[2019-01-17 13:07:06] Ep. 7 : Up. 217500 : Sen. 34,297,499 : Cost 23.84411049 : Time 452.39s : 13711.29 words/s : L.r. 8.1368e-05
[2019-01-17 13:14:39] Ep. 7 : Up. 218000 : Sen. 34,956,056 : Cost 24.02034760 : Time 452.97s : 13778.58 words/s : L.r. 8.1274e-05
[2019-01-17 13:22:09] Ep. 7 : Up. 218500 : Sen. 35,605,690 : Cost 24.01134109 : Time 449.94s : 13681.21 words/s : L.r. 8.1181e-05
[2019-01-17 13:29:37] Ep. 7 : Up. 219000 : Sen. 36,255,758 : Cost 24.07882690 : Time 447.62s : 13790.19 words/s : L.r. 8.1088e-05
[2019-01-17 13:37:09] Ep. 7 : Up. 219500 : Sen. 36,911,422 : Cost 24.06385040 : Time 451.92s : 13760.02 words/s : L.r. 8.0996e-05
[2019-01-17 13:44:40] Ep. 7 : Up. 220000 : Sen. 37,570,736 : Cost 23.86023140 : Time 450.76s : 13782.23 words/s : L.r. 8.0904e-05
[2019-01-17 13:44:40] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 13:44:43] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter220000.npz
[2019-01-17 13:44:47] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 13:44:52] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 13:45:03] [valid] Ep. 7 : Up. 220000 : cross-entropy : 19.1199 : new best
[2019-01-17 13:45:05] [valid] Ep. 7 : Up. 220000 : perplexity : 4.4082 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 13:46:35] [valid] Ep. 7 : Up. 220000 : translation : 34.74 : stalled 1 times
[2019-01-17 13:54:05] Ep. 7 : Up. 220500 : Sen. 38,224,384 : Cost 24.10243034 : Time 564.93s : 11007.97 words/s : L.r. 8.0812e-05
[2019-01-17 14:01:39] Ep. 7 : Up. 221000 : Sen. 38,889,273 : Cost 23.96961975 : Time 454.01s : 13868.70 words/s : L.r. 8.0721e-05
[2019-01-17 14:09:07] Ep. 7 : Up. 221500 : Sen. 39,538,430 : Cost 24.03268623 : Time 448.26s : 13731.49 words/s : L.r. 8.0630e-05
[2019-01-17 14:16:33] Ep. 7 : Up. 222000 : Sen. 40,190,064 : Cost 23.96726608 : Time 446.63s : 13807.73 words/s : L.r. 8.0539e-05
[2019-01-17 14:24:01] Ep. 7 : Up. 222500 : Sen. 40,841,602 : Cost 24.04011726 : Time 447.56s : 13808.50 words/s : L.r. 8.0448e-05
[2019-01-17 14:31:33] Ep. 7 : Up. 223000 : Sen. 41,506,606 : Cost 23.84910774 : Time 452.14s : 13871.16 words/s : L.r. 8.0358e-05
[2019-01-17 14:34:16] Seen 41736931 samples
[2019-01-17 14:34:16] Starting epoch 8
[2019-01-17 14:34:16] [data] Shuffling files
[2019-01-17 14:34:31] [data] Done reading 41736982 sentences
[2019-01-17 14:38:16] [data] Done shuffling 41736982 sentences to temp files
[2019-01-17 14:43:06] Ep. 8 : Up. 223500 : Sen. 411,767 : Cost 23.99880600 : Time 693.30s : 8799.97 words/s : L.r. 8.0268e-05
[2019-01-17 14:50:33] Ep. 8 : Up. 224000 : Sen. 1,065,352 : Cost 23.81120491 : Time 446.06s : 13838.09 words/s : L.r. 8.0178e-05
[2019-01-17 14:58:04] Ep. 8 : Up. 224500 : Sen. 1,727,200 : Cost 23.93064499 : Time 451.93s : 13895.97 words/s : L.r. 8.0089e-05
[2019-01-17 15:05:33] Ep. 8 : Up. 225000 : Sen. 2,383,122 : Cost 23.91272163 : Time 448.15s : 13874.60 words/s : L.r. 8.0000e-05
[2019-01-17 15:05:33] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 15:05:37] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter225000.npz
[2019-01-17 15:05:41] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 15:05:45] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 15:05:56] [valid] Ep. 8 : Up. 225000 : cross-entropy : 19.1043 : new best
[2019-01-17 15:05:59] [valid] Ep. 8 : Up. 225000 : perplexity : 4.40285 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 15:07:21] [valid] Ep. 8 : Up. 225000 : translation : 34.78 : stalled 2 times
[2019-01-17 15:14:50] Ep. 8 : Up. 225500 : Sen. 3,037,794 : Cost 23.95415688 : Time 557.07s : 11159.40 words/s : L.r. 7.9911e-05
[2019-01-17 15:22:18] Ep. 8 : Up. 226000 : Sen. 3,693,425 : Cost 23.83948517 : Time 448.40s : 13824.35 words/s : L.r. 7.9823e-05
[2019-01-17 15:29:46] Ep. 8 : Up. 226500 : Sen. 4,346,120 : Cost 23.92989349 : Time 447.58s : 13826.37 words/s : L.r. 7.9735e-05
[2019-01-17 15:37:10] Ep. 8 : Up. 227000 : Sen. 4,995,866 : Cost 23.91540718 : Time 444.56s : 13847.16 words/s : L.r. 7.9647e-05
[2019-01-17 15:44:37] Ep. 8 : Up. 227500 : Sen. 5,650,544 : Cost 23.96726608 : Time 446.79s : 13916.16 words/s : L.r. 7.9559e-05
[2019-01-17 15:52:01] Ep. 8 : Up. 228000 : Sen. 6,299,764 : Cost 24.05537033 : Time 444.25s : 13916.97 words/s : L.r. 7.9472e-05
[2019-01-17 15:59:26] Ep. 8 : Up. 228500 : Sen. 6,958,414 : Cost 23.63074684 : Time 444.96s : 13872.42 words/s : L.r. 7.9385e-05
[2019-01-17 16:06:57] Ep. 8 : Up. 229000 : Sen. 7,613,025 : Cost 24.11610222 : Time 451.08s : 13849.65 words/s : L.r. 7.9298e-05
[2019-01-17 16:14:21] Ep. 8 : Up. 229500 : Sen. 8,266,471 : Cost 23.92115402 : Time 443.99s : 13932.10 words/s : L.r. 7.9212e-05
[2019-01-17 16:21:47] Ep. 8 : Up. 230000 : Sen. 8,924,662 : Cost 23.74469185 : Time 445.65s : 13902.97 words/s : L.r. 7.9126e-05
[2019-01-17 16:21:47] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 16:21:51] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter230000.npz
[2019-01-17 16:21:55] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 16:22:00] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 16:22:11] [valid] Ep. 8 : Up. 230000 : cross-entropy : 19.099 : new best
[2019-01-17 16:22:14] [valid] Ep. 8 : Up. 230000 : perplexity : 4.40105 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 16:23:37] [valid] Ep. 8 : Up. 230000 : translation : 34.73 : stalled 3 times
[2019-01-17 16:31:08] Ep. 8 : Up. 230500 : Sen. 9,579,087 : Cost 24.14157867 : Time 561.12s : 11143.84 words/s : L.r. 7.9040e-05
[2019-01-17 16:38:37] Ep. 8 : Up. 231000 : Sen. 10,234,527 : Cost 23.87269211 : Time 449.23s : 13797.66 words/s : L.r. 7.8954e-05
[2019-01-17 16:46:04] Ep. 8 : Up. 231500 : Sen. 10,890,881 : Cost 23.87349129 : Time 446.55s : 13896.58 words/s : L.r. 7.8869e-05
[2019-01-17 16:53:29] Ep. 8 : Up. 232000 : Sen. 11,540,482 : Cost 23.97840691 : Time 445.51s : 13843.35 words/s : L.r. 7.8784e-05
[2019-01-17 17:00:57] Ep. 8 : Up. 232500 : Sen. 12,194,506 : Cost 24.04604530 : Time 447.64s : 13908.15 words/s : L.r. 7.8699e-05
[2019-01-17 17:08:27] Ep. 8 : Up. 233000 : Sen. 12,853,458 : Cost 23.90307426 : Time 449.88s : 13857.00 words/s : L.r. 7.8615e-05
[2019-01-17 17:15:56] Ep. 8 : Up. 233500 : Sen. 13,510,600 : Cost 23.78094864 : Time 449.34s : 13783.11 words/s : L.r. 7.8530e-05
[2019-01-17 17:23:23] Ep. 8 : Up. 234000 : Sen. 14,158,827 : Cost 24.00568581 : Time 446.54s : 13803.45 words/s : L.r. 7.8446e-05
[2019-01-17 17:30:53] Ep. 8 : Up. 234500 : Sen. 14,821,097 : Cost 23.74829292 : Time 449.98s : 13857.68 words/s : L.r. 7.8363e-05
[2019-01-17 17:38:23] Ep. 8 : Up. 235000 : Sen. 15,472,800 : Cost 24.08554649 : Time 449.95s : 13806.49 words/s : L.r. 7.8279e-05
[2019-01-17 17:38:23] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 17:38:27] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter235000.npz
[2019-01-17 17:38:31] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 17:38:35] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 17:38:47] [valid] Ep. 8 : Up. 235000 : cross-entropy : 19.0929 : new best
[2019-01-17 17:38:50] [valid] Ep. 8 : Up. 235000 : perplexity : 4.39897 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 17:40:10] [valid] Ep. 8 : Up. 235000 : translation : 34.73 : stalled 4 times
[2019-01-17 17:47:41] Ep. 8 : Up. 235500 : Sen. 16,128,416 : Cost 23.92295456 : Time 558.63s : 11115.51 words/s : L.r. 7.8196e-05
[2019-01-17 17:55:12] Ep. 8 : Up. 236000 : Sen. 16,781,868 : Cost 23.92107582 : Time 450.54s : 13729.10 words/s : L.r. 7.8113e-05
[2019-01-17 18:02:46] Ep. 8 : Up. 236500 : Sen. 17,441,464 : Cost 23.93296051 : Time 454.20s : 13769.74 words/s : L.r. 7.8031e-05
[2019-01-17 18:10:13] Ep. 8 : Up. 237000 : Sen. 18,088,214 : Cost 24.04917908 : Time 446.92s : 13772.18 words/s : L.r. 7.7948e-05
[2019-01-17 18:17:45] Ep. 8 : Up. 237500 : Sen. 18,744,973 : Cost 23.80569839 : Time 451.79s : 13711.88 words/s : L.r. 7.7866e-05
[2019-01-17 18:25:13] Ep. 8 : Up. 238000 : Sen. 19,391,096 : Cost 23.95088768 : Time 448.03s : 13674.03 words/s : L.r. 7.7784e-05
[2019-01-17 18:32:44] Ep. 8 : Up. 238500 : Sen. 20,044,925 : Cost 23.91003799 : Time 451.42s : 13703.25 words/s : L.r. 7.7703e-05
[2019-01-17 18:40:19] Ep. 8 : Up. 239000 : Sen. 20,704,402 : Cost 23.84329796 : Time 454.29s : 13705.72 words/s : L.r. 7.7622e-05
[2019-01-17 18:47:50] Ep. 8 : Up. 239500 : Sen. 21,351,451 : Cost 24.14514923 : Time 451.65s : 13675.06 words/s : L.r. 7.7540e-05
[2019-01-17 18:55:25] Ep. 8 : Up. 240000 : Sen. 22,009,727 : Cost 23.93662453 : Time 455.06s : 13711.67 words/s : L.r. 7.7460e-05
[2019-01-17 18:55:25] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 18:55:30] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter240000.npz
[2019-01-17 18:55:34] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 18:55:38] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 18:55:49] [valid] Ep. 8 : Up. 240000 : cross-entropy : 19.0901 : new best
[2019-01-17 18:55:52] [valid] Ep. 8 : Up. 240000 : perplexity : 4.398 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 18:57:21] [valid] Ep. 8 : Up. 240000 : translation : 34.75 : stalled 5 times
[2019-01-17 19:04:54] Ep. 8 : Up. 240500 : Sen. 22,664,878 : Cost 23.77929878 : Time 569.19s : 10847.12 words/s : L.r. 7.7379e-05
[2019-01-17 19:12:26] Ep. 8 : Up. 241000 : Sen. 23,312,473 : Cost 24.12826347 : Time 451.72s : 13683.24 words/s : L.r. 7.7299e-05
[2019-01-17 19:20:02] Ep. 8 : Up. 241500 : Sen. 23,970,402 : Cost 23.98913193 : Time 455.56s : 13706.60 words/s : L.r. 7.7219e-05
[2019-01-17 19:27:37] Ep. 8 : Up. 242000 : Sen. 24,634,583 : Cost 23.79023933 : Time 455.69s : 13735.92 words/s : L.r. 7.7139e-05
[2019-01-17 19:35:11] Ep. 8 : Up. 242500 : Sen. 25,288,298 : Cost 23.97168732 : Time 453.71s : 13675.40 words/s : L.r. 7.7059e-05
[2019-01-17 19:42:42] Ep. 8 : Up. 243000 : Sen. 25,936,939 : Cost 24.09001732 : Time 451.29s : 13686.73 words/s : L.r. 7.6980e-05
[2019-01-17 19:50:16] Ep. 8 : Up. 243500 : Sen. 26,593,393 : Cost 23.93019104 : Time 453.60s : 13715.59 words/s : L.r. 7.6901e-05
[2019-01-17 19:57:49] Ep. 8 : Up. 244000 : Sen. 27,250,976 : Cost 23.78488159 : Time 453.23s : 13657.05 words/s : L.r. 7.6822e-05
[2019-01-17 20:05:22] Ep. 8 : Up. 244500 : Sen. 27,904,800 : Cost 24.03322601 : Time 452.89s : 13731.29 words/s : L.r. 7.6744e-05
[2019-01-17 20:12:52] Ep. 8 : Up. 245000 : Sen. 28,558,159 : Cost 23.77331924 : Time 449.83s : 13682.01 words/s : L.r. 7.6665e-05
[2019-01-17 20:12:52] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 20:12:56] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter245000.npz
[2019-01-17 20:13:00] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 20:13:05] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 20:13:15] [valid] Ep. 8 : Up. 245000 : cross-entropy : 19.0861 : new best
[2019-01-17 20:13:18] [valid] Ep. 8 : Up. 245000 : perplexity : 4.39664 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 20:14:44] [valid] Ep. 8 : Up. 245000 : translation : 34.83 : new best
[2019-01-17 20:22:17] Ep. 8 : Up. 245500 : Sen. 29,215,059 : Cost 23.99612999 : Time 565.34s : 11033.36 words/s : L.r. 7.6587e-05
[2019-01-17 20:29:47] Ep. 8 : Up. 246000 : Sen. 29,866,488 : Cost 24.08231544 : Time 450.17s : 13786.13 words/s : L.r. 7.6509e-05
[2019-01-17 20:37:20] Ep. 8 : Up. 246500 : Sen. 30,526,096 : Cost 23.87234879 : Time 452.21s : 13782.49 words/s : L.r. 7.6432e-05
[2019-01-17 20:44:48] Ep. 8 : Up. 247000 : Sen. 31,174,505 : Cost 23.87996674 : Time 448.41s : 13676.23 words/s : L.r. 7.6354e-05
[2019-01-17 20:52:17] Ep. 8 : Up. 247500 : Sen. 31,826,901 : Cost 23.98501778 : Time 448.58s : 13814.54 words/s : L.r. 7.6277e-05
[2019-01-17 20:59:48] Ep. 8 : Up. 248000 : Sen. 32,484,668 : Cost 23.84551811 : Time 451.25s : 13774.79 words/s : L.r. 7.6200e-05
[2019-01-17 21:07:15] Ep. 8 : Up. 248500 : Sen. 33,136,650 : Cost 24.02439880 : Time 446.97s : 13870.48 words/s : L.r. 7.6123e-05
[2019-01-17 21:14:42] Ep. 8 : Up. 249000 : Sen. 33,786,749 : Cost 23.90090752 : Time 446.95s : 13768.02 words/s : L.r. 7.6047e-05
[2019-01-17 21:22:10] Ep. 8 : Up. 249500 : Sen. 34,443,644 : Cost 23.86240768 : Time 448.10s : 13852.13 words/s : L.r. 7.5971e-05
[2019-01-17 21:29:34] Ep. 8 : Up. 250000 : Sen. 35,091,515 : Cost 24.10846138 : Time 444.13s : 13910.13 words/s : L.r. 7.5895e-05
[2019-01-17 21:29:34] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 21:29:39] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter250000.npz
[2019-01-17 21:29:42] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 21:29:47] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 21:29:58] [valid] Ep. 8 : Up. 250000 : cross-entropy : 19.0713 : new best
[2019-01-17 21:30:01] [valid] Ep. 8 : Up. 250000 : perplexity : 4.3916 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 21:31:27] [valid] Ep. 8 : Up. 250000 : translation : 34.87 : new best
[2019-01-17 21:38:57] Ep. 8 : Up. 250500 : Sen. 35,755,350 : Cost 23.81104851 : Time 563.20s : 11124.48 words/s : L.r. 7.5819e-05
[2019-01-17 21:46:24] Ep. 8 : Up. 251000 : Sen. 36,408,037 : Cost 23.91578102 : Time 446.78s : 13831.62 words/s : L.r. 7.5743e-05
[2019-01-17 21:53:52] Ep. 8 : Up. 251500 : Sen. 37,063,453 : Cost 23.87515068 : Time 447.50s : 13851.75 words/s : L.r. 7.5668e-05
[2019-01-17 22:01:14] Ep. 8 : Up. 252000 : Sen. 37,707,537 : Cost 24.04441261 : Time 441.99s : 13874.95 words/s : L.r. 7.5593e-05
[2019-01-17 22:08:40] Ep. 8 : Up. 252500 : Sen. 38,360,268 : Cost 24.08840561 : Time 446.20s : 13940.60 words/s : L.r. 7.5518e-05
[2019-01-17 22:16:05] Ep. 8 : Up. 253000 : Sen. 39,018,020 : Cost 23.67660713 : Time 445.43s : 13851.25 words/s : L.r. 7.5443e-05
[2019-01-17 22:23:34] Ep. 8 : Up. 253500 : Sen. 39,675,860 : Cost 23.92100143 : Time 449.09s : 13885.52 words/s : L.r. 7.5369e-05
[2019-01-17 22:31:03] Ep. 8 : Up. 254000 : Sen. 40,336,767 : Cost 23.90175819 : Time 449.15s : 13930.66 words/s : L.r. 7.5295e-05
[2019-01-17 22:38:28] Ep. 8 : Up. 254500 : Sen. 40,987,131 : Cost 23.91491127 : Time 444.68s : 13848.75 words/s : L.r. 7.5221e-05
[2019-01-17 22:45:56] Ep. 8 : Up. 255000 : Sen. 41,640,499 : Cost 24.00151443 : Time 448.15s : 13848.57 words/s : L.r. 7.5147e-05
[2019-01-17 22:45:56] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-17 22:46:01] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter255000.npz
[2019-01-17 22:46:04] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-17 22:46:09] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-17 22:46:20] [valid] Ep. 8 : Up. 255000 : cross-entropy : 19.0583 : new best
[2019-01-17 22:46:23] [valid] Ep. 8 : Up. 255000 : perplexity : 4.38719 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-17 22:47:53] [valid] Ep. 8 : Up. 255000 : translation : 34.86 : stalled 1 times
[2019-01-17 22:49:01] Seen 41736931 samples
[2019-01-17 22:49:01] Starting epoch 9
[2019-01-17 22:49:01] [data] Shuffling files
[2019-01-17 22:49:16] [data] Done reading 41736982 sentences
[2019-01-17 22:52:56] [data] Done shuffling 41736982 sentences to temp files
[2019-01-17 22:59:22] Ep. 9 : Up. 255500 : Sen. 552,240 : Cost 23.71478653 : Time 805.38s : 7608.53 words/s : L.r. 7.5073e-05
[2019-01-17 23:06:49] Ep. 9 : Up. 256000 : Sen. 1,200,907 : Cost 24.07791138 : Time 447.42s : 13878.11 words/s : L.r. 7.5000e-05
[2019-01-17 23:14:16] Ep. 9 : Up. 256500 : Sen. 1,856,904 : Cost 23.67203712 : Time 447.13s : 13820.17 words/s : L.r. 7.4927e-05
[2019-01-17 23:21:46] Ep. 9 : Up. 257000 : Sen. 2,513,588 : Cost 23.65144348 : Time 449.35s : 13745.93 words/s : L.r. 7.4854e-05
[2019-01-17 23:29:11] Ep. 9 : Up. 257500 : Sen. 3,154,876 : Cost 24.17722130 : Time 445.40s : 13812.53 words/s : L.r. 7.4781e-05
[2019-01-17 23:36:43] Ep. 9 : Up. 258000 : Sen. 3,809,731 : Cost 23.98201942 : Time 452.35s : 13798.73 words/s : L.r. 7.4709e-05
[2019-01-17 23:44:13] Ep. 9 : Up. 258500 : Sen. 4,470,223 : Cost 23.54754257 : Time 450.05s : 13757.89 words/s : L.r. 7.4636e-05
[2019-01-17 23:51:44] Ep. 9 : Up. 259000 : Sen. 5,122,264 : Cost 23.83457565 : Time 450.75s : 13703.41 words/s : L.r. 7.4564e-05
[2019-01-17 23:59:13] Ep. 9 : Up. 259500 : Sen. 5,771,887 : Cost 23.90910339 : Time 449.17s : 13726.99 words/s : L.r. 7.4493e-05
[2019-01-18 00:06:47] Ep. 9 : Up. 260000 : Sen. 6,431,992 : Cost 23.80516815 : Time 453.79s : 13754.82 words/s : L.r. 7.4421e-05
[2019-01-18 00:06:47] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 00:06:51] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter260000.npz
[2019-01-18 00:06:55] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 00:07:00] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 00:07:11] [valid] Ep. 9 : Up. 260000 : cross-entropy : 19.0534 : new best
[2019-01-18 00:07:13] [valid] Ep. 9 : Up. 260000 : perplexity : 4.38552 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 00:08:38] [valid] Ep. 9 : Up. 260000 : translation : 34.85 : stalled 2 times
[2019-01-18 00:16:10] Ep. 9 : Up. 260500 : Sen. 7,088,452 : Cost 23.77106476 : Time 562.82s : 11016.79 words/s : L.r. 7.4349e-05
[2019-01-18 00:23:39] Ep. 9 : Up. 261000 : Sen. 7,735,486 : Cost 24.00425148 : Time 449.39s : 13717.78 words/s : L.r. 7.4278e-05
[2019-01-18 00:31:10] Ep. 9 : Up. 261500 : Sen. 8,387,717 : Cost 23.85698128 : Time 450.28s : 13735.06 words/s : L.r. 7.4207e-05
[2019-01-18 00:38:40] Ep. 9 : Up. 262000 : Sen. 9,038,185 : Cost 23.81680489 : Time 449.95s : 13676.35 words/s : L.r. 7.4136e-05
[2019-01-18 00:46:15] Ep. 9 : Up. 262500 : Sen. 9,700,507 : Cost 23.74513626 : Time 455.86s : 13720.67 words/s : L.r. 7.4066e-05
[2019-01-18 00:53:50] Ep. 9 : Up. 263000 : Sen. 10,350,061 : Cost 24.15481186 : Time 454.11s : 13699.72 words/s : L.r. 7.3995e-05
[2019-01-18 01:01:22] Ep. 9 : Up. 263500 : Sen. 11,007,086 : Cost 23.68566704 : Time 452.85s : 13656.45 words/s : L.r. 7.3925e-05
[2019-01-18 01:08:52] Ep. 9 : Up. 264000 : Sen. 11,653,398 : Cost 23.86067200 : Time 449.98s : 13608.67 words/s : L.r. 7.3855e-05
[2019-01-18 01:16:28] Ep. 9 : Up. 264500 : Sen. 12,309,725 : Cost 24.08788681 : Time 455.48s : 13770.56 words/s : L.r. 7.3785e-05
[2019-01-18 01:24:00] Ep. 9 : Up. 265000 : Sen. 12,966,804 : Cost 23.57846642 : Time 452.23s : 13615.88 words/s : L.r. 7.3715e-05
[2019-01-18 01:24:00] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 01:24:04] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter265000.npz
[2019-01-18 01:24:08] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 01:24:12] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 01:24:23] [valid] Ep. 9 : Up. 265000 : cross-entropy : 19.0499 : new best
[2019-01-18 01:24:26] [valid] Ep. 9 : Up. 265000 : perplexity : 4.38433 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 01:25:50] [valid] Ep. 9 : Up. 265000 : translation : 34.79 : stalled 3 times
[2019-01-18 01:33:23] Ep. 9 : Up. 265500 : Sen. 13,617,533 : Cost 23.96571922 : Time 562.52s : 11010.51 words/s : L.r. 7.3646e-05
[2019-01-18 01:40:57] Ep. 9 : Up. 266000 : Sen. 14,274,778 : Cost 23.87926292 : Time 454.61s : 13702.54 words/s : L.r. 7.3577e-05
[2019-01-18 01:48:31] Ep. 9 : Up. 266500 : Sen. 14,931,359 : Cost 23.84593201 : Time 453.74s : 13704.13 words/s : L.r. 7.3508e-05
[2019-01-18 01:56:05] Ep. 9 : Up. 267000 : Sen. 15,591,415 : Cost 23.78276825 : Time 454.33s : 13730.19 words/s : L.r. 7.3439e-05
[2019-01-18 02:03:37] Ep. 9 : Up. 267500 : Sen. 16,245,685 : Cost 23.81895065 : Time 451.73s : 13700.68 words/s : L.r. 7.3370e-05
[2019-01-18 02:11:11] Ep. 9 : Up. 268000 : Sen. 16,902,989 : Cost 23.80806923 : Time 454.01s : 13693.85 words/s : L.r. 7.3302e-05
[2019-01-18 02:18:44] Ep. 9 : Up. 268500 : Sen. 17,557,783 : Cost 23.94984436 : Time 453.48s : 13739.49 words/s : L.r. 7.3233e-05
[2019-01-18 02:26:16] Ep. 9 : Up. 269000 : Sen. 18,210,852 : Cost 23.92983627 : Time 451.97s : 13711.72 words/s : L.r. 7.3165e-05
[2019-01-18 02:33:50] Ep. 9 : Up. 269500 : Sen. 18,872,319 : Cost 23.79647446 : Time 453.09s : 13800.29 words/s : L.r. 7.3097e-05
[2019-01-18 02:41:21] Ep. 9 : Up. 270000 : Sen. 19,528,052 : Cost 23.94151688 : Time 451.32s : 13809.19 words/s : L.r. 7.3030e-05
[2019-01-18 02:41:21] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 02:41:25] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter270000.npz
[2019-01-18 02:41:29] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 02:41:33] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 02:41:44] [valid] Ep. 9 : Up. 270000 : cross-entropy : 19.0414 : new best
[2019-01-18 02:41:47] [valid] Ep. 9 : Up. 270000 : perplexity : 4.38144 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 02:43:14] [valid] Ep. 9 : Up. 270000 : translation : 34.9 : new best
[2019-01-18 02:50:40] Ep. 9 : Up. 270500 : Sen. 20,177,300 : Cost 23.87182999 : Time 559.45s : 10998.90 words/s : L.r. 7.2962e-05
[2019-01-18 02:58:13] Ep. 9 : Up. 271000 : Sen. 20,841,724 : Cost 23.59992218 : Time 452.85s : 13770.55 words/s : L.r. 7.2895e-05
[2019-01-18 03:05:45] Ep. 9 : Up. 271500 : Sen. 21,498,008 : Cost 23.95623398 : Time 451.85s : 13809.71 words/s : L.r. 7.2828e-05
[2019-01-18 03:13:17] Ep. 9 : Up. 272000 : Sen. 22,158,123 : Cost 24.00598907 : Time 452.10s : 13902.00 words/s : L.r. 7.2761e-05
[2019-01-18 03:20:46] Ep. 9 : Up. 272500 : Sen. 22,807,751 : Cost 23.90377426 : Time 448.59s : 13735.87 words/s : L.r. 7.2694e-05
[2019-01-18 03:28:15] Ep. 9 : Up. 273000 : Sen. 23,463,581 : Cost 23.81671906 : Time 449.10s : 13811.52 words/s : L.r. 7.2627e-05
[2019-01-18 03:35:44] Ep. 9 : Up. 273500 : Sen. 24,119,115 : Cost 23.86078262 : Time 448.89s : 13839.47 words/s : L.r. 7.2561e-05
[2019-01-18 03:43:14] Ep. 9 : Up. 274000 : Sen. 24,779,213 : Cost 23.71934128 : Time 450.59s : 13809.08 words/s : L.r. 7.2495e-05
[2019-01-18 03:50:43] Ep. 9 : Up. 274500 : Sen. 25,428,589 : Cost 24.03853607 : Time 448.59s : 13806.13 words/s : L.r. 7.2429e-05
[2019-01-18 03:58:13] Ep. 9 : Up. 275000 : Sen. 26,091,220 : Cost 23.74298286 : Time 449.83s : 13915.99 words/s : L.r. 7.2363e-05
[2019-01-18 03:58:13] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 03:58:17] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter275000.npz
[2019-01-18 03:58:21] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 03:58:27] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 03:58:38] [valid] Ep. 9 : Up. 275000 : cross-entropy : 19.0371 : new best
[2019-01-18 03:58:41] [valid] Ep. 9 : Up. 275000 : perplexity : 4.37996 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 04:00:07] [valid] Ep. 9 : Up. 275000 : translation : 34.77 : stalled 1 times
[2019-01-18 04:07:32] Ep. 9 : Up. 275500 : Sen. 26,741,296 : Cost 23.97878075 : Time 559.59s : 11049.97 words/s : L.r. 7.2297e-05
[2019-01-18 04:15:04] Ep. 9 : Up. 276000 : Sen. 27,402,448 : Cost 23.90637016 : Time 451.75s : 13888.64 words/s : L.r. 7.2232e-05
[2019-01-18 04:22:29] Ep. 9 : Up. 276500 : Sen. 28,059,105 : Cost 23.78466606 : Time 445.15s : 13941.06 words/s : L.r. 7.2166e-05
[2019-01-18 04:29:56] Ep. 9 : Up. 277000 : Sen. 28,713,599 : Cost 23.81620407 : Time 446.50s : 13858.28 words/s : L.r. 7.2101e-05
[2019-01-18 04:37:19] Ep. 9 : Up. 277500 : Sen. 29,366,292 : Cost 23.85507774 : Time 443.64s : 13931.50 words/s : L.r. 7.2036e-05
[2019-01-18 04:44:42] Ep. 9 : Up. 278000 : Sen. 30,016,000 : Cost 23.91726685 : Time 443.01s : 13917.25 words/s : L.r. 7.1971e-05
[2019-01-18 04:52:09] Ep. 9 : Up. 278500 : Sen. 30,677,549 : Cost 23.79490471 : Time 446.67s : 13999.07 words/s : L.r. 7.1907e-05
[2019-01-18 04:59:39] Ep. 9 : Up. 279000 : Sen. 31,337,446 : Cost 23.96670723 : Time 449.87s : 13942.14 words/s : L.r. 7.1842e-05
[2019-01-18 05:07:03] Ep. 9 : Up. 279500 : Sen. 31,985,126 : Cost 24.04978943 : Time 444.52s : 13902.36 words/s : L.r. 7.1778e-05
[2019-01-18 05:14:28] Ep. 9 : Up. 280000 : Sen. 32,644,869 : Cost 23.71118355 : Time 444.35s : 13989.62 words/s : L.r. 7.1714e-05
[2019-01-18 05:14:28] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 05:14:32] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter280000.npz
[2019-01-18 05:14:36] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 05:14:41] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 05:14:51] [valid] Ep. 9 : Up. 280000 : cross-entropy : 19.0289 : new best
[2019-01-18 05:14:54] [valid] Ep. 9 : Up. 280000 : perplexity : 4.3772 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 05:16:25] [valid] Ep. 9 : Up. 280000 : translation : 34.72 : stalled 2 times
[2019-01-18 05:23:50] Ep. 9 : Up. 280500 : Sen. 33,298,381 : Cost 23.86306381 : Time 562.52s : 11005.00 words/s : L.r. 7.1650e-05
[2019-01-18 05:31:17] Ep. 9 : Up. 281000 : Sen. 33,950,567 : Cost 23.89784431 : Time 446.79s : 13854.53 words/s : L.r. 7.1586e-05
[2019-01-18 05:38:42] Ep. 9 : Up. 281500 : Sen. 34,597,943 : Cost 23.98055458 : Time 445.04s : 13846.65 words/s : L.r. 7.1522e-05
[2019-01-18 05:46:09] Ep. 9 : Up. 282000 : Sen. 35,255,786 : Cost 23.73732376 : Time 446.59s : 13891.50 words/s : L.r. 7.1459e-05
[2019-01-18 05:53:36] Ep. 9 : Up. 282500 : Sen. 35,909,561 : Cost 23.97622299 : Time 447.01s : 13910.73 words/s : L.r. 7.1396e-05
[2019-01-18 06:01:04] Ep. 9 : Up. 283000 : Sen. 36,570,126 : Cost 23.68548393 : Time 448.62s : 13858.13 words/s : L.r. 7.1333e-05
[2019-01-18 06:08:32] Ep. 9 : Up. 283500 : Sen. 37,222,367 : Cost 24.00239182 : Time 447.14s : 13886.67 words/s : L.r. 7.1270e-05
[2019-01-18 06:16:00] Ep. 9 : Up. 284000 : Sen. 37,878,669 : Cost 23.80559731 : Time 448.67s : 13831.19 words/s : L.r. 7.1207e-05
[2019-01-18 06:23:29] Ep. 9 : Up. 284500 : Sen. 38,539,646 : Cost 23.78900719 : Time 448.94s : 13926.09 words/s : L.r. 7.1144e-05
[2019-01-18 06:30:59] Ep. 9 : Up. 285000 : Sen. 39,191,144 : Cost 23.92041969 : Time 450.24s : 13749.18 words/s : L.r. 7.1082e-05
[2019-01-18 06:30:59] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 06:31:04] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter285000.npz
[2019-01-18 06:31:08] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 06:31:12] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 06:31:23] [valid] Ep. 9 : Up. 285000 : cross-entropy : 19.0021 : new best
[2019-01-18 06:31:26] [valid] Ep. 9 : Up. 285000 : perplexity : 4.3681 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 06:32:53] [valid] Ep. 9 : Up. 285000 : translation : 34.74 : stalled 3 times
[2019-01-18 06:40:25] Ep. 9 : Up. 285500 : Sen. 39,849,640 : Cost 23.87748337 : Time 565.48s : 11038.23 words/s : L.r. 7.1020e-05
[2019-01-18 06:47:56] Ep. 9 : Up. 286000 : Sen. 40,507,600 : Cost 23.90559387 : Time 451.66s : 13840.69 words/s : L.r. 7.0957e-05
[2019-01-18 06:55:28] Ep. 9 : Up. 286500 : Sen. 41,163,899 : Cost 23.76585770 : Time 451.30s : 13728.82 words/s : L.r. 7.0896e-05
[2019-01-18 07:02:03] Seen 41736931 samples
[2019-01-18 07:02:03] Starting epoch 10
[2019-01-18 07:02:03] [data] Shuffling files
[2019-01-18 07:02:18] [data] Done reading 41736982 sentences
[2019-01-18 07:05:59] [data] Done shuffling 41736982 sentences to temp files
[2019-01-18 07:06:58] Ep. 10 : Up. 287000 : Sen. 75,497 : Cost 23.79158211 : Time 690.03s : 8882.00 words/s : L.r. 7.0834e-05
[2019-01-18 07:14:28] Ep. 10 : Up. 287500 : Sen. 722,819 : Cost 23.97403336 : Time 450.15s : 13723.19 words/s : L.r. 7.0772e-05
[2019-01-18 07:22:00] Ep. 10 : Up. 288000 : Sen. 1,379,475 : Cost 23.80785179 : Time 451.79s : 13798.51 words/s : L.r. 7.0711e-05
[2019-01-18 07:29:29] Ep. 10 : Up. 288500 : Sen. 2,033,098 : Cost 23.54939651 : Time 448.81s : 13685.86 words/s : L.r. 7.0649e-05
[2019-01-18 07:37:02] Ep. 10 : Up. 289000 : Sen. 2,692,832 : Cost 23.84143066 : Time 453.82s : 13796.92 words/s : L.r. 7.0588e-05
[2019-01-18 07:44:33] Ep. 10 : Up. 289500 : Sen. 3,350,588 : Cost 23.74482155 : Time 450.98s : 13806.24 words/s : L.r. 7.0527e-05
[2019-01-18 07:52:05] Ep. 10 : Up. 290000 : Sen. 4,002,410 : Cost 23.99471283 : Time 452.01s : 13785.01 words/s : L.r. 7.0466e-05
[2019-01-18 07:52:05] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 07:52:10] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter290000.npz
[2019-01-18 07:52:13] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 07:52:18] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 07:52:29] [valid] Ep. 10 : Up. 290000 : cross-entropy : 19.001 : new best
[2019-01-18 07:52:32] [valid] Ep. 10 : Up. 290000 : perplexity : 4.36769 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 07:53:54] [valid] Ep. 10 : Up. 290000 : translation : 34.73 : stalled 4 times
[2019-01-18 08:01:27] Ep. 10 : Up. 290500 : Sen. 4,662,567 : Cost 23.49915314 : Time 561.53s : 11025.49 words/s : L.r. 7.0406e-05
[2019-01-18 08:09:00] Ep. 10 : Up. 291000 : Sen. 5,315,950 : Cost 23.83445930 : Time 452.90s : 13703.18 words/s : L.r. 7.0345e-05
[2019-01-18 08:16:34] Ep. 10 : Up. 291500 : Sen. 5,966,394 : Cost 23.90252113 : Time 453.71s : 13651.31 words/s : L.r. 7.0285e-05
[2019-01-18 08:24:08] Ep. 10 : Up. 292000 : Sen. 6,623,782 : Cost 23.88432312 : Time 454.76s : 13738.66 words/s : L.r. 7.0225e-05
[2019-01-18 08:31:39] Ep. 10 : Up. 292500 : Sen. 7,272,123 : Cost 23.82950020 : Time 450.51s : 13648.82 words/s : L.r. 7.0165e-05
[2019-01-18 08:39:11] Ep. 10 : Up. 293000 : Sen. 7,927,250 : Cost 23.78709412 : Time 452.23s : 13725.75 words/s : L.r. 7.0105e-05
[2019-01-18 08:46:44] Ep. 10 : Up. 293500 : Sen. 8,583,645 : Cost 23.77093887 : Time 453.26s : 13711.76 words/s : L.r. 7.0045e-05
[2019-01-18 08:54:18] Ep. 10 : Up. 294000 : Sen. 9,240,252 : Cost 23.68303490 : Time 454.06s : 13642.82 words/s : L.r. 6.9985e-05
[2019-01-18 09:01:51] Ep. 10 : Up. 294500 : Sen. 9,893,419 : Cost 23.81266594 : Time 452.32s : 13691.92 words/s : L.r. 6.9926e-05
[2019-01-18 09:09:22] Ep. 10 : Up. 295000 : Sen. 10,544,550 : Cost 23.78427505 : Time 451.74s : 13652.81 words/s : L.r. 6.9867e-05
[2019-01-18 09:09:22] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 09:09:27] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter295000.npz
[2019-01-18 09:09:30] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 09:09:35] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 09:09:46] [valid] Ep. 10 : Up. 295000 : cross-entropy : 18.9977 : new best
[2019-01-18 09:09:49] [valid] Ep. 10 : Up. 295000 : perplexity : 4.36656 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 09:11:15] [valid] Ep. 10 : Up. 295000 : translation : 34.8 : stalled 5 times
[2019-01-18 09:18:47] Ep. 10 : Up. 295500 : Sen. 11,195,080 : Cost 23.83421135 : Time 564.44s : 10937.92 words/s : L.r. 6.9808e-05
[2019-01-18 09:26:17] Ep. 10 : Up. 296000 : Sen. 11,843,941 : Cost 23.88297272 : Time 450.20s : 13688.39 words/s : L.r. 6.9749e-05
[2019-01-18 09:33:48] Ep. 10 : Up. 296500 : Sen. 12,495,621 : Cost 23.75570297 : Time 451.14s : 13658.62 words/s : L.r. 6.9690e-05
[2019-01-18 09:41:22] Ep. 10 : Up. 297000 : Sen. 13,154,951 : Cost 23.75954437 : Time 454.23s : 13727.01 words/s : L.r. 6.9631e-05
[2019-01-18 09:48:57] Ep. 10 : Up. 297500 : Sen. 13,811,334 : Cost 23.91241074 : Time 454.23s : 13756.83 words/s : L.r. 6.9573e-05
[2019-01-18 09:56:28] Ep. 10 : Up. 298000 : Sen. 14,467,320 : Cost 23.75823402 : Time 451.27s : 13752.06 words/s : L.r. 6.9514e-05
[2019-01-18 10:04:00] Ep. 10 : Up. 298500 : Sen. 15,121,476 : Cost 23.79913139 : Time 452.52s : 13697.28 words/s : L.r. 6.9456e-05
[2019-01-18 10:11:31] Ep. 10 : Up. 299000 : Sen. 15,776,683 : Cost 23.71858406 : Time 450.47s : 13732.20 words/s : L.r. 6.9398e-05
[2019-01-18 10:19:06] Ep. 10 : Up. 299500 : Sen. 16,437,702 : Cost 23.90151024 : Time 455.59s : 13802.02 words/s : L.r. 6.9340e-05
[2019-01-18 10:26:35] Ep. 10 : Up. 300000 : Sen. 17,088,000 : Cost 23.73764610 : Time 448.49s : 13708.93 words/s : L.r. 6.9282e-05
[2019-01-18 10:26:35] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 10:26:39] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter300000.npz
[2019-01-18 10:26:43] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 10:26:47] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 10:26:58] [valid] Ep. 10 : Up. 300000 : cross-entropy : 18.9955 : new best
[2019-01-18 10:27:01] [valid] Ep. 10 : Up. 300000 : perplexity : 4.36587 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 10:28:26] [valid] Ep. 10 : Up. 300000 : translation : 34.86 : stalled 6 times
[2019-01-18 10:35:55] Ep. 10 : Up. 300500 : Sen. 17,739,191 : Cost 23.82442856 : Time 559.74s : 11020.59 words/s : L.r. 6.9224e-05
[2019-01-18 10:43:26] Ep. 10 : Up. 301000 : Sen. 18,394,987 : Cost 23.74095917 : Time 451.09s : 13735.29 words/s : L.r. 6.9167e-05
[2019-01-18 10:50:55] Ep. 10 : Up. 301500 : Sen. 19,048,517 : Cost 23.73706055 : Time 449.49s : 13745.86 words/s : L.r. 6.9109e-05
[2019-01-18 10:58:24] Ep. 10 : Up. 302000 : Sen. 19,703,512 : Cost 23.95048141 : Time 448.82s : 13902.41 words/s : L.r. 6.9052e-05
[2019-01-18 11:05:53] Ep. 10 : Up. 302500 : Sen. 20,359,016 : Cost 23.82598114 : Time 449.03s : 13839.16 words/s : L.r. 6.8995e-05
[2019-01-18 11:13:23] Ep. 10 : Up. 303000 : Sen. 21,013,761 : Cost 23.73391533 : Time 449.99s : 13746.38 words/s : L.r. 6.8938e-05
[2019-01-18 11:20:50] Ep. 10 : Up. 303500 : Sen. 21,659,426 : Cost 23.99691582 : Time 446.48s : 13816.50 words/s : L.r. 6.8881e-05
[2019-01-18 11:28:20] Ep. 10 : Up. 304000 : Sen. 22,319,817 : Cost 23.59414864 : Time 449.97s : 13801.05 words/s : L.r. 6.8825e-05
[2019-01-18 11:35:50] Ep. 10 : Up. 304500 : Sen. 22,976,000 : Cost 23.80520058 : Time 450.31s : 13798.69 words/s : L.r. 6.8768e-05
[2019-01-18 11:43:16] Ep. 10 : Up. 305000 : Sen. 23,627,309 : Cost 23.84180069 : Time 446.35s : 13840.05 words/s : L.r. 6.8712e-05
[2019-01-18 11:43:16] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 11:43:20] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter305000.npz
[2019-01-18 11:43:24] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 11:43:28] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 11:43:39] [valid] Ep. 10 : Up. 305000 : cross-entropy : 18.9881 : new best
[2019-01-18 11:43:42] [valid] Ep. 10 : Up. 305000 : perplexity : 4.36334 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 11:45:10] [valid] Ep. 10 : Up. 305000 : translation : 34.67 : stalled 7 times
[2019-01-18 11:52:36] Ep. 10 : Up. 305500 : Sen. 24,284,071 : Cost 23.63785744 : Time 559.95s : 11040.37 words/s : L.r. 6.8656e-05
[2019-01-18 12:00:05] Ep. 10 : Up. 306000 : Sen. 24,938,356 : Cost 23.86961555 : Time 448.99s : 13831.84 words/s : L.r. 6.8599e-05
[2019-01-18 12:07:37] Ep. 10 : Up. 306500 : Sen. 25,599,200 : Cost 23.96723366 : Time 451.46s : 13950.87 words/s : L.r. 6.8543e-05
[2019-01-18 12:15:03] Ep. 10 : Up. 307000 : Sen. 26,253,259 : Cost 23.83263397 : Time 446.00s : 13909.09 words/s : L.r. 6.8488e-05
[2019-01-18 12:22:28] Ep. 10 : Up. 307500 : Sen. 26,903,938 : Cost 23.85619164 : Time 444.95s : 13882.81 words/s : L.r. 6.8432e-05
[2019-01-18 12:29:52] Ep. 10 : Up. 308000 : Sen. 27,554,299 : Cost 23.78982925 : Time 444.59s : 13858.49 words/s : L.r. 6.8376e-05
[2019-01-18 12:37:17] Ep. 10 : Up. 308500 : Sen. 28,204,945 : Cost 23.87274551 : Time 444.65s : 13886.69 words/s : L.r. 6.8321e-05
[2019-01-18 12:44:44] Ep. 10 : Up. 309000 : Sen. 28,864,000 : Cost 23.75964737 : Time 447.10s : 13948.30 words/s : L.r. 6.8266e-05
[2019-01-18 12:52:09] Ep. 10 : Up. 309500 : Sen. 29,516,817 : Cost 23.90673065 : Time 445.37s : 13939.28 words/s : L.r. 6.8210e-05
[2019-01-18 12:59:31] Ep. 10 : Up. 310000 : Sen. 30,171,054 : Cost 23.79795647 : Time 441.80s : 14042.02 words/s : L.r. 6.8155e-05
[2019-01-18 12:59:31] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 12:59:35] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter310000.npz
[2019-01-18 12:59:39] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 12:59:44] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 12:59:55] [valid] Ep. 10 : Up. 310000 : cross-entropy : 18.9736 : new best
[2019-01-18 12:59:57] [valid] Ep. 10 : Up. 310000 : perplexity : 4.35845 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 13:01:21] [valid] Ep. 10 : Up. 310000 : translation : 34.7 : stalled 8 times
[2019-01-18 13:08:49] Ep. 10 : Up. 310500 : Sen. 30,828,426 : Cost 23.77051353 : Time 557.89s : 11142.62 words/s : L.r. 6.8101e-05
[2019-01-18 13:16:10] Ep. 10 : Up. 311000 : Sen. 31,471,484 : Cost 23.96078491 : Time 441.21s : 13881.03 words/s : L.r. 6.8046e-05
[2019-01-18 13:23:36] Ep. 10 : Up. 311500 : Sen. 32,129,456 : Cost 23.61930847 : Time 445.71s : 13881.02 words/s : L.r. 6.7991e-05
[2019-01-18 13:30:59] Ep. 10 : Up. 312000 : Sen. 32,778,929 : Cost 23.84239769 : Time 443.28s : 13891.59 words/s : L.r. 6.7937e-05
[2019-01-18 13:38:30] Ep. 10 : Up. 312500 : Sen. 33,437,706 : Cost 23.76167870 : Time 450.88s : 13818.30 words/s : L.r. 6.7882e-05
[2019-01-18 13:45:58] Ep. 10 : Up. 313000 : Sen. 34,091,672 : Cost 23.76751137 : Time 447.54s : 13815.68 words/s : L.r. 6.7828e-05
[2019-01-18 13:53:25] Ep. 10 : Up. 313500 : Sen. 34,739,939 : Cost 23.92694473 : Time 446.89s : 13793.02 words/s : L.r. 6.7774e-05
[2019-01-18 14:00:51] Ep. 10 : Up. 314000 : Sen. 35,393,936 : Cost 23.75278854 : Time 446.89s : 13847.20 words/s : L.r. 6.7720e-05
[2019-01-18 14:08:22] Ep. 10 : Up. 314500 : Sen. 36,047,902 : Cost 23.95116615 : Time 450.28s : 13829.61 words/s : L.r. 6.7666e-05
[2019-01-18 14:15:52] Ep. 10 : Up. 315000 : Sen. 36,706,554 : Cost 23.67836189 : Time 450.21s : 13788.14 words/s : L.r. 6.7612e-05
[2019-01-18 14:15:52] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 14:15:57] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter315000.npz
[2019-01-18 14:16:00] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 14:16:05] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 14:16:16] [valid] Ep. 10 : Up. 315000 : cross-entropy : 18.9656 : new best
[2019-01-18 14:16:19] [valid] Ep. 10 : Up. 315000 : perplexity : 4.35574 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 14:17:44] [valid] Ep. 10 : Up. 315000 : translation : 34.64 : stalled 9 times
[2019-01-18 14:25:19] Ep. 10 : Up. 315500 : Sen. 37,366,803 : Cost 23.83668900 : Time 567.35s : 11030.87 words/s : L.r. 6.7559e-05
[2019-01-18 14:32:48] Ep. 10 : Up. 316000 : Sen. 38,018,573 : Cost 23.77939034 : Time 449.08s : 13743.32 words/s : L.r. 6.7505e-05
[2019-01-18 14:40:25] Ep. 10 : Up. 316500 : Sen. 38,677,895 : Cost 23.83397293 : Time 456.42s : 13709.02 words/s : L.r. 6.7452e-05
[2019-01-18 14:48:00] Ep. 10 : Up. 317000 : Sen. 39,338,483 : Cost 23.71940041 : Time 454.76s : 13713.32 words/s : L.r. 6.7399e-05
[2019-01-18 14:55:34] Ep. 10 : Up. 317500 : Sen. 39,994,172 : Cost 23.88847542 : Time 454.85s : 13681.39 words/s : L.r. 6.7346e-05
[2019-01-18 15:03:07] Ep. 10 : Up. 318000 : Sen. 40,649,517 : Cost 23.79610062 : Time 453.02s : 13693.89 words/s : L.r. 6.7293e-05
[2019-01-18 15:10:43] Ep. 10 : Up. 318500 : Sen. 41,303,916 : Cost 23.98893738 : Time 455.95s : 13684.52 words/s : L.r. 6.7240e-05
[2019-01-18 15:15:46] Seen 41736931 samples
[2019-01-18 15:15:46] Starting epoch 11
[2019-01-18 15:15:46] [data] Shuffling files
[2019-01-18 15:16:01] [data] Done reading 41736982 sentences
[2019-01-18 15:19:41] [data] Done shuffling 41736982 sentences to temp files
[2019-01-18 15:22:17] Ep. 11 : Up. 319000 : Sen. 211,279 : Cost 23.84437180 : Time 693.90s : 8821.21 words/s : L.r. 6.7187e-05
[2019-01-18 15:29:50] Ep. 11 : Up. 319500 : Sen. 864,010 : Cost 23.59372330 : Time 452.34s : 13614.18 words/s : L.r. 6.7135e-05
[2019-01-18 15:37:21] Ep. 11 : Up. 320000 : Sen. 1,517,116 : Cost 23.73705673 : Time 451.61s : 13712.59 words/s : L.r. 6.7082e-05
[2019-01-18 15:37:21] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 15:37:26] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter320000.npz
[2019-01-18 15:37:29] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 15:37:34] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 15:37:45] [valid] Ep. 11 : Up. 320000 : cross-entropy : 18.9532 : new best
[2019-01-18 15:37:48] [valid] Ep. 11 : Up. 320000 : perplexity : 4.35154 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 15:39:16] [valid] Ep. 11 : Up. 320000 : translation : 34.61 : stalled 10 times
[2019-01-18 15:46:52] Ep. 11 : Up. 320500 : Sen. 2,176,520 : Cost 23.77608490 : Time 570.98s : 10972.84 words/s : L.r. 6.7030e-05
[2019-01-18 15:54:28] Ep. 11 : Up. 321000 : Sen. 2,841,927 : Cost 23.54321861 : Time 455.64s : 13745.17 words/s : L.r. 6.6977e-05
[2019-01-18 16:01:57] Ep. 11 : Up. 321500 : Sen. 3,488,720 : Cost 23.78557205 : Time 449.13s : 13662.42 words/s : L.r. 6.6925e-05
[2019-01-18 16:09:29] Ep. 11 : Up. 322000 : Sen. 4,147,776 : Cost 23.69651794 : Time 451.77s : 13802.88 words/s : L.r. 6.6873e-05
[2019-01-18 16:17:01] Ep. 11 : Up. 322500 : Sen. 4,802,952 : Cost 23.74785233 : Time 451.82s : 13733.96 words/s : L.r. 6.6822e-05
[2019-01-18 16:24:31] Ep. 11 : Up. 323000 : Sen. 5,455,879 : Cost 23.85678673 : Time 450.73s : 13792.38 words/s : L.r. 6.6770e-05
[2019-01-18 16:32:00] Ep. 11 : Up. 323500 : Sen. 6,112,737 : Cost 23.53891945 : Time 448.55s : 13770.13 words/s : L.r. 6.6718e-05
[2019-01-18 16:39:30] Ep. 11 : Up. 324000 : Sen. 6,767,839 : Cost 23.78832626 : Time 449.72s : 13823.58 words/s : L.r. 6.6667e-05
[2019-01-18 16:46:55] Ep. 11 : Up. 324500 : Sen. 7,417,673 : Cost 23.74375725 : Time 445.64s : 13807.99 words/s : L.r. 6.6615e-05
[2019-01-18 16:54:22] Ep. 11 : Up. 325000 : Sen. 8,070,120 : Cost 23.74500465 : Time 446.41s : 13846.38 words/s : L.r. 6.6564e-05
[2019-01-18 16:54:22] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 16:54:26] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter325000.npz
[2019-01-18 16:54:30] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 16:54:36] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 16:54:47] [valid] Ep. 11 : Up. 325000 : cross-entropy : 18.947 : new best
[2019-01-18 16:54:50] [valid] Ep. 11 : Up. 325000 : perplexity : 4.34946 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 16:56:16] [valid] Ep. 11 : Up. 325000 : translation : 34.69 : stalled 11 times
[2019-01-18 17:03:39] Ep. 11 : Up. 325500 : Sen. 8,716,969 : Cost 23.87485886 : Time 557.36s : 11047.95 words/s : L.r. 6.6513e-05
[2019-01-18 17:11:02] Ep. 11 : Up. 326000 : Sen. 9,365,940 : Cost 23.69001579 : Time 442.89s : 13850.12 words/s : L.r. 6.6462e-05
[2019-01-18 17:18:29] Ep. 11 : Up. 326500 : Sen. 10,026,523 : Cost 23.75062180 : Time 447.68s : 13989.63 words/s : L.r. 6.6411e-05
[2019-01-18 17:25:55] Ep. 11 : Up. 327000 : Sen. 10,678,452 : Cost 23.74107170 : Time 445.24s : 13869.05 words/s : L.r. 6.6360e-05
[2019-01-18 17:33:21] Ep. 11 : Up. 327500 : Sen. 11,330,736 : Cost 23.71404648 : Time 445.94s : 13842.83 words/s : L.r. 6.6309e-05
[2019-01-18 17:40:49] Ep. 11 : Up. 328000 : Sen. 11,989,441 : Cost 23.74027824 : Time 448.80s : 13901.07 words/s : L.r. 6.6259e-05
[2019-01-18 17:48:15] Ep. 11 : Up. 328500 : Sen. 12,636,967 : Cost 23.86376381 : Time 445.23s : 13831.70 words/s : L.r. 6.6208e-05
[2019-01-18 17:55:42] Ep. 11 : Up. 329000 : Sen. 13,287,573 : Cost 23.84483910 : Time 447.13s : 13828.00 words/s : L.r. 6.6158e-05
[2019-01-18 18:03:14] Ep. 11 : Up. 329500 : Sen. 13,947,830 : Cost 23.60524178 : Time 452.21s : 13763.41 words/s : L.r. 6.6108e-05
[2019-01-18 18:10:50] Ep. 11 : Up. 330000 : Sen. 14,610,678 : Cost 23.77364922 : Time 456.30s : 13760.71 words/s : L.r. 6.6058e-05
[2019-01-18 18:10:50] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 18:10:55] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter330000.npz
[2019-01-18 18:10:58] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 18:11:03] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 18:11:14] [valid] Ep. 11 : Up. 330000 : cross-entropy : 18.9471 : stalled 1 times
[2019-01-18 18:11:17] [valid] Ep. 11 : Up. 330000 : perplexity : 4.34951 : stalled 1 times
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 18:12:42] [valid] Ep. 11 : Up. 330000 : translation : 34.73 : stalled 12 times
[2019-01-18 18:20:13] Ep. 11 : Up. 330500 : Sen. 15,265,078 : Cost 23.72661591 : Time 562.29s : 11010.92 words/s : L.r. 6.6008e-05
[2019-01-18 18:27:44] Ep. 11 : Up. 331000 : Sen. 15,916,812 : Cost 23.84959602 : Time 451.03s : 13733.13 words/s : L.r. 6.5958e-05
[2019-01-18 18:35:14] Ep. 11 : Up. 331500 : Sen. 16,566,603 : Cost 23.65320015 : Time 450.23s : 13622.80 words/s : L.r. 6.5908e-05
[2019-01-18 18:42:50] Ep. 11 : Up. 332000 : Sen. 17,224,842 : Cost 23.79513931 : Time 455.88s : 13698.48 words/s : L.r. 6.5859e-05
[2019-01-18 18:50:24] Ep. 11 : Up. 332500 : Sen. 17,876,801 : Cost 23.90305138 : Time 454.18s : 13674.96 words/s : L.r. 6.5809e-05
[2019-01-18 18:57:57] Ep. 11 : Up. 333000 : Sen. 18,532,133 : Cost 23.70631218 : Time 453.34s : 13655.28 words/s : L.r. 6.5760e-05
[2019-01-18 19:05:31] Ep. 11 : Up. 333500 : Sen. 19,187,802 : Cost 23.65401840 : Time 453.81s : 13628.19 words/s : L.r. 6.5710e-05
[2019-01-18 19:13:07] Ep. 11 : Up. 334000 : Sen. 19,844,638 : Cost 23.90741920 : Time 456.05s : 13717.30 words/s : L.r. 6.5661e-05
[2019-01-18 19:20:46] Ep. 11 : Up. 334500 : Sen. 20,510,906 : Cost 23.72306824 : Time 459.12s : 13734.52 words/s : L.r. 6.5612e-05
[2019-01-18 19:28:17] Ep. 11 : Up. 335000 : Sen. 21,161,426 : Cost 23.84162903 : Time 450.55s : 13717.85 words/s : L.r. 6.5563e-05
[2019-01-18 19:28:17] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 19:28:21] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter335000.npz
[2019-01-18 19:28:25] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 19:28:29] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 19:28:40] [valid] Ep. 11 : Up. 335000 : cross-entropy : 18.9422 : new best
[2019-01-18 19:28:43] [valid] Ep. 11 : Up. 335000 : perplexity : 4.34784 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 19:30:10] [valid] Ep. 11 : Up. 335000 : translation : 34.79 : stalled 13 times
[2019-01-18 19:37:41] Ep. 11 : Up. 335500 : Sen. 21,813,658 : Cost 23.72895813 : Time 564.01s : 10936.07 words/s : L.r. 6.5514e-05
[2019-01-18 19:45:11] Ep. 11 : Up. 336000 : Sen. 22,468,868 : Cost 23.80341339 : Time 450.25s : 13812.83 words/s : L.r. 6.5465e-05
[2019-01-18 19:52:41] Ep. 11 : Up. 336500 : Sen. 23,122,097 : Cost 23.79147530 : Time 450.06s : 13755.42 words/s : L.r. 6.5417e-05
[2019-01-18 20:00:12] Ep. 11 : Up. 337000 : Sen. 23,780,048 : Cost 23.72818375 : Time 450.60s : 13813.65 words/s : L.r. 6.5368e-05
[2019-01-18 20:07:37] Ep. 11 : Up. 337500 : Sen. 24,428,913 : Cost 23.71812248 : Time 445.12s : 13786.23 words/s : L.r. 6.5320e-05
[2019-01-18 20:15:06] Ep. 11 : Up. 338000 : Sen. 25,086,440 : Cost 23.82345581 : Time 449.24s : 13907.11 words/s : L.r. 6.5271e-05
[2019-01-18 20:22:33] Ep. 11 : Up. 338500 : Sen. 25,740,760 : Cost 23.72926712 : Time 447.07s : 13853.22 words/s : L.r. 6.5223e-05
[2019-01-18 20:30:03] Ep. 11 : Up. 339000 : Sen. 26,397,476 : Cost 24.00094032 : Time 449.85s : 13943.14 words/s : L.r. 6.5175e-05
[2019-01-18 20:37:25] Ep. 11 : Up. 339500 : Sen. 27,050,212 : Cost 23.62033653 : Time 442.05s : 13907.43 words/s : L.r. 6.5127e-05
[2019-01-18 20:44:50] Ep. 11 : Up. 340000 : Sen. 27,703,903 : Cost 23.66517067 : Time 444.62s : 13876.78 words/s : L.r. 6.5079e-05
[2019-01-18 20:44:50] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz.orig.npz
[2019-01-18 20:44:54] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.iter340000.npz
[2019-01-18 20:44:58] Saving model weights and runtime parameters to model/model.src1tgt0.newvocab.npz
[2019-01-18 20:45:02] Saving Adam parameters to model/model.src1tgt0.newvocab.npz.optimizer.npz
[2019-01-18 20:45:13] [valid] Ep. 11 : Up. 340000 : cross-entropy : 18.9327 : new best
[2019-01-18 20:45:16] [valid] Ep. 11 : Up. 340000 : perplexity : 4.34464 : new best
Detokenizer Version $Revision: 4134 $
Language: en
[2019-01-18 20:46:44] [valid] Ep. 11 : Up. 340000 : translation : 34.81 : stalled 14 times
[2019-01-18 20:54:12] Ep. 11 : Up. 340500 : Sen. 28,355,019 : Cost 23.85865784 : Time 562.14s : 11012.05 words/s : L.r. 6.5031e-05
[2019-01-18 21:01:43] Ep. 11 : Up. 341000 : Sen. 29,011,901 : Cost 23.77913284 : Time 450.86s : 13813.10 words/s : L.r. 6.4984e-05
[2019-01-18 21:09:13] Ep. 11 : Up. 341500 : Sen. 29,671,702 : Cost 23.58547592 : Time 449.88s : 13806.76 words/s : L.r. 6.4936e-05
[2019-01-18 21:16:39] Ep. 11 : Up. 342000 : Sen. 30,323,545 : Cost 23.82650375 : Time 446.39s : 13870.88 words/s : L.r. 6.4889e-05
[2019-01-18 21:24:07] Ep. 11 : Up. 342500 : Sen. 30,971,914 : Cost 23.95740318 : Time 448.39s : 13798.81 words/s : L.r. 6.4841e-05
[2019-01-18 21:31:37] Ep. 11 : Up. 343000 : Sen. 31,624,396 : Cost 23.77358246 : Time 449.81s : 13748.41 words/s : L.r. 6.4794e-05
[2019-01-18 21:39:07] Ep. 11 : Up. 343500 : Sen. 32,282,863 : Cost 23.75393677 : Time 450.31s : 13840.46 words/s : L.r. 6.4747e-05
[2019-01-18 21:46:40] Ep. 11 : Up. 344000 : Sen. 32,942,719 : Cost 23.71043015 : Time 452.32s : 13807.20 words/s : L.r. 6.4700e-05
[2019-01-18 21:54:13] Ep. 11 : Up. 344500 : Sen. 33,599,200 : Cost 23.70258522 : Time 453.67s : 13678.42 words/s : L.r. 6.4653e-05
