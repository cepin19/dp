marian=/home/big_maggie/usr/marian_metis/marian_1.7.3/marian-dev/build/marian-scorer


$marian -m /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_fr/model/model.src1tgt0.newvocab.3.iter440000.npz  -v /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_fr/corp/vocab.encz.opensub.new.yml  /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_fr/corp/vocab.encz.opensub.new.yml  -t coherence-cohesion.opensub.src coherence-cohesion.opensub.correct --cpu-threads=8 -n > correct_scores

$marian -m /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_fr/model/model.src1tgt0.newvocab.3.iter440000.npz -v /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_fr/corp/vocab.encz.opensub.new.yml  /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_fr/corp/vocab.encz.opensub.new.yml  -t coherence-cohesion.opensub.src coherence-cohesion.opensub.incorrect --cpu-threads=8 -n > incorrect_scores

~                                                                                                                                                                       
~             
