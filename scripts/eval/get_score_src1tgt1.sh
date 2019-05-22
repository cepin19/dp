marian=/home/big_maggie/usr/marian_metis/marian_1.7.3/marian-dev/build/marian-scorer


$marian -m /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_fr/model/model.src1tgt1.len165.iter345000.npz  -v /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_fr/corp/vocab.encz.opensub.yml  /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_fr/corp/vocab.encz.opensub.yml  -t coherence-cohesion.opensub.src1tgt1 coherence-cohesion.opensub.correct --cpu-threads=8 -n > correct_scores

$marian -m /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_fr/model/model.src1tgt1.len165.iter345000.npz -v /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_fr/corp/vocab.encz.opensub.yml  /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_fr/corp/vocab.encz.opensub.yml  -t coherence-cohesion.opensub.src1tgt1 coherence-cohesion.opensub.incorrect --cpu-threads=8 -n > incorrect_scores

~                                                                                                                                                                       
~             
