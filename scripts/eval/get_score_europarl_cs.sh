marian=/home/big_maggie/usr/marian_cosmas/marian_1.7.8/marian-dev/build/marian-scorer

model=/home/large/data/models/marian/encz_exp/doc-level-nmt/europarl/Europarl/src1tgt0/model/model.src1tgt0.1.len.npz.best-translation.npz
vocab=/home/large/data/models/marian/encz_exp/doc-level-nmt/europarl/Europarl/src1tgt0/corp/vocab.encz.europarl.yml
$marian -m $model  -v $vocab $vocab  -t disambig.cs.europarl.src disambig.cs.europarl.correct --cpu-threads=8 > correct_scores
$marian -m $model  -v $vocab $vocab  -t disambig.cs.europarl.src disambig.cs.europarl.incorrect --cpu-threads=8 > incorrect_scores

~                                                                                                                                                                       
~             
