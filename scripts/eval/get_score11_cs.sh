marian=/home/big_maggie/usr/marian_cosmas/marian_1.7.8/marian-dev/build/marian-scorer


$marian -m /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_cz/model/model.src1tgt1.npz  -v /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_cz/corp/vocab.encz.opensub.yml  /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_cz/corp/vocab.encz.opensub.yml  -t disambig.cs.opensub.src disambig.cs.opensub.correct --cpu-threads=8 > correct_scores

$marian -m /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_cz/model/model.src1tgt1.npz -v /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_cz/corp/vocab.encz.opensub.yml  /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt1_cz/corp/vocab.encz.opensub.yml  -t disambig.cs.opensub.src disambig.cs.opensub.incorrect --cpu-threads=8 > incorrect_scores

~                                                                                                                                                                       
~             
