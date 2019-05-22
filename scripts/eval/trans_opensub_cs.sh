marian=/home/big_maggie/usr/marian_metis/marian_1.7.8/marian-dev/build/marian-decoder

model=/home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_cz/model/model.src1tgt0.iter490000.npz
model_base=/home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src0tgt0_cz/model/model.src0tgt0.iter375000.npz
vocab=/home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_cz/corp/vocab.encz.opensub.yml
vocab_base=/home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src0tgt0_cz/corp/vocab.encz.opensub.yml
$marian -m $model_base  -v $vocab_base $vocab_base  -i disambig.cs.opensub.nocontext.src  --mini-batch 8 -d 1 > disambig_opensub_base
$marian -m $model  -v $vocab $vocab  -i disambig.cs.opensub.src  --mini-batch 8 -d 1 > disambig_opensub_concat

~                                                                                                                                                                       
~             
