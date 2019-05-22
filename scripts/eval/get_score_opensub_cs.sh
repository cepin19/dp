marian=/home/big_maggie/usr/marian_cosmas/marian_1.7.8/marian-dev/build/marian-scorer

model=/home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_cz/model/model.src1tgt0.iter490000.npz
vocab=/home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_cz/corp/vocab.encz.opensub.yml
$marian -m $model  -v $vocab $vocab  -t disambig.cs.opensub.src disambig.cs.opensub.correct --cpu-threads=8 > correct_scores
$marian -m $model  -v $vocab $vocab  -t disambig.cs.opensub.src disambig.cs.opensub.incorrect --cpu-threads=8 > incorrect_scores

~                                                                                                                                                                       
~             
