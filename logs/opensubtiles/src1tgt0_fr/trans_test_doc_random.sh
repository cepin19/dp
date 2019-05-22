dev=0
marian=/home/big_maggie/usr/marian_cosmas/marian_1.7.8/marian-dev/build
moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
marian=/home/large/data/models/marian/marian-doc/doc-marian3_cosmas_prev_gate/build
model=model/model.src1tgt0.doc.new.spider.prevgate.iter45000.npz
sys_name=doc_rand

if [ "$3" != "" ]; then
    n=$3
else
    n=0.6
fi

vocab=corp/vocab.encz.opensub.new.yml

for n in {6..6}
do
n=$(bc -l <<< $n/10);
echo $n >> out_test_"$sys_name"_desc


echo $model >> out_test_"$sys_name"_desc

$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab  $vocab -m  $model --mini-batch 64 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev_null corp/opensub.en-fr.docs.dev.en.bpe.src > out_test_$sys_name
cat out_test_$sys_name | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post_$sys_name
cat out_test_post_$sys_name | python3 /home/big_maggie/usr/sacrebleu/sacrebleu.py corp/opensub.en-fr.docs.dev.fr  -m bleu chrf >> out_test_"$sys_name"_desc
cat out_test_"$sys_name"_desc
done
