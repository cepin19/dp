dev=1
marian=/home/big_maggie/usr/marian_prometheus/marian_1.7.3/marian-dev/build
moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
for n in {6..29}
do
n=$(bc -l <<< $n/10);
echo $n
base_model=model/model.src0tgt0.iter375000.npz

vocab=corp/vocab.encz.opensub.yml
$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab  -m  $base_model --mini-batch 16 -i corp/opensub.cs-en.docs.dev.en.bpe  > out_test
echo $n  >> base 
echo >>  base
echo "real" >>base
echo >> base
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.cs-en.docs.dev.cs  >> base
echo >> base
rm out_test
rm out_test_post

done
