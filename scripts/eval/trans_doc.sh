marian=/home/large/data/models/marian/marian-doc/doc-marian3_metis/build/marian-decoder
#marian=/home/large/data/models/marian/marian-doc/doc-marian3_metis_prev_gate_voita/build/marian-decoder
model=model.src1tgt0.doc.new.spider.newgate.nogate.iter15000.npz
model=model.src1tgt0.doc.new.spider.prevgate.npz
$marian -m /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_fr/model/$model  -v /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_fr/corp/vocab.encz.opensub.new.yml  /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_fr/corp/vocab.encz.opensub.new.yml  /home/large/data/models/marian/encz_exp/doc-level-nmt/opensub/OpenSubtitles2018/src1tgt0_fr/corp/vocab.encz.opensub.new.yml -i coherence-cohesion.opensub.src.dual.src_prev coherence-cohesion.opensub.src.dual.src -d 1 --mini-batch 1                                                                                                                                                                       
~             
