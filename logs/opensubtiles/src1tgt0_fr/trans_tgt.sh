dev=1
marian=/home/big_maggie/usr/marian_spider/marian_1.7.6/marian-dev/build
doc_marian=/home/large/data/models/marian/marian-doc/same_emb_new_gate/doc-marian/build

moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/


for n in {6..6}
do
n=$(bc -l <<< $n/10);
echo $n
concat_model=model/model.src1tgt0.newvocab.3.iter440000.npz

vocab=corp/vocab.encz.opensub.new.yml
echo "CONCAT"
$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab  -m  $concat_model --mini-batch 32 -i corp/opensub.en-fr.docs.test.en.bpe  > out_test
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 /home/big_maggie/usr/sacrebleu/sacrebleu.py corp/opensub.en-fr.docs.test.fr 
mv out_test opensub.tgt.test.translation.bpe
rm out_test
rm out_test_post
done
