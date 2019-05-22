dev=1
marian=/home/big_maggie/usr/marian_cosmas/marian_1.7.8/marian-dev/build
moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
#marian=/home/large/data/models/marian/marian-doc/doc-marian3_cosmas_prev_gate/build
model=$1
sys_name=$2

if [ "$3" != "" ]; then
    n=$3
else
    n=0.6
fi
dir=`dirname "$0"`

vocab=$dir/corp/vocab.encz.opensub.new.yml

echo $model >> out_test_"$sys_name"_desc
echo $n  >> out_test_"$sys_name"_desc

$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab  $vocab -m  $model --mini-batch 32 -i $dir/corp/opensub.en-fr.docs.test.en.bpe.src $dir/corp/opensub.en-fr.docs.test.en.bpe.src > out_test_$sys_name
cat out_test_$sys_name | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post_$sys_name
cat out_test_post_$sys_name | python3 /home/big_maggie/usr/sacrebleu/sacrebleu.py $dir/../opensub.en-fr.docs.test.fr.detok --chrf-beta 1 --width 4 -m bleu chrf >> out_test_"$sys_name"_desc
cat out_test_post_$sys_name | python3 /home/big_maggie/usr/sacrebleu/sacrebleu.py $dir/../opensub.en-fr.docs.test.fr.detok --chrf-beta 3 --width 4  -m chrf >> out_test_"$sys_name"_desc


cat out_test_"$sys_name"_desc
