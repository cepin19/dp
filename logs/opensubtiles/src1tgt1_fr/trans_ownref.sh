dev=1
marian=/home/big_maggie/usr/marian_spider/marian_1.7.6/marian-dev/build
doc_marian=/home/large/data/models/marian/marian-doc/same_emb_new_gate/doc-marian/build

moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/


for n in {6..29}
do
n=$(bc -l <<< $n/10);
echo $n >> mt_ns
concat_model=model/model.src1tgt1.len165.iter345000.npz
vocab=corp/vocab.encz.opensub.yml
echo "CONCAT"
$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab  -m  $concat_model --mini-batch 64 -i corp/opensub.en-fr.docs.dev.en.bpe.owntgt > out_test
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3  /home/big_maggie/usr/sacrebleu/sacrebleu.py corp/opensub.en-fr.docs.dev.fr  >> mt_ns

done
