dev=1
marian=/home/big_maggie/usr/marian_spider/marian_1.7.6/marian-dev/build
doc_marian=/home/large/data/models/marian/marian-doc/same_emb_new_gate/doc-marian/build

moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
marian=/home/large/data/models/marian/marian-doc/doc-marian3_spider3/build/

for n in {6..6}
do
n=$(bc -l <<< $n/10);
echo $n
concat_model=model/model.src1tgt0.doc.new.spider.newgate.iter200000.npz
concat_model=model/model.src1tgt0.doc.new.spider.prevgate.withgate.npz
#concat_model=model/model.src1tgt0.doc.new.spider.newgate.npz
#concat_model=model/model.src1tgt0.doc.new.spider.prevgate.withgate.npz
vocab=corp/vocab.encz.opensub.new.yml
echo "CONCAT"

$marian/marian-decoder --context-gate  -d $dev  -n $n -b 6 --maxi-batch 100 -v $vocab $vocab $vocab  -m  $concat_model --mini-batch 32 --maxi-batch-sort src -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev  corp/opensub.en-fr.docs.dev.en.bpe.src  > out_test
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 /home/big_maggie/usr/sacrebleu/sacrebleu.py corp/opensub.en-fr.docs.dev.fr 
done
