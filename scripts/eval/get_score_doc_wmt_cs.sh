marian=/home/large/data/models/marian/marian-doc/same_emb_no_transpose_run1/marian-dev/build//marian-scorer
marian=/home/large/data/models/marian/marian-doc/doc-marian-cosmas/build/marian-scorer
marian=/home/big_maggie/usr/marian_cosmas/marian_1.7.8/marian-dev/build/marian-scorer
marian=/home/large/data/models/marian/marian-doc/doc-marian3_cosmas/build//marian-scorer
model=/home/large/data/models/marian/encz_exp/wmt19/model/model_bt_noise_encz_bicleaner_spider3_doc_from_base.npz.best-perplexity.npz
model=/home/large/data/models/marian/encz_exp/wmt19/model/model_bt_noise_encz_bicleaner_cosmas_doc_from_base.nogate.npz.best-translation.npz
model=/home/large/data/models/marian/encz_exp/wmt19/model/model_bt_noise_encz_bicleaner_cosmas_doc.new.npz.best-translation.npz
vocab=/home/large/data/models/marian/encz_exp/wmt19/corp/vocab.encs.yml
$marian -m  $model -v $vocab $vocab $vocab -t  disambig.cs.raw.src.src_prev.bpe disambig.cs.raw.src.src.bpe  disambig.cs.raw.correct.bpe  --cpu-threads=8 > correct_scores

$marian -m  $model  -v $vocab $vocab $vocab -t  disambig.cs.raw.src.src_prev.bpe disambig.cs.raw.src.src.bpe  disambig.cs.raw.incorrect.bpe --cpu-threads=8 > incorrect_scores

~                                                                                                                                                                       
~             
