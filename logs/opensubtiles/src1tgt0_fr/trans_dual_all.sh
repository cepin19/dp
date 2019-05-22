dev=2
marian=/home/big_maggie/usr/marian_prometheus/marian_1.7.5/marian-dev/build
doc_marian=/home/large/data/models/marian/marian-doc/same_emb_new_gate/doc-marian/build

moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/


for n in {6..29}
do
n=$(bc -l <<< $n/10);
echo $n
shared_model=model/model.src1tgt0.dual.shared.iter250000.npz
shared_tok_model=model/model.src1tgt0.dual.shared.tok.iter360000.npz

vocab=corp/vocab.encz.opensub.new.yml
echo "shared"
$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab $vocab  -m  $shared_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev corp/opensub.en-fr.docs.dev.en.bpe.src > out_test
echo $n  >> shared
echo >> shared
echo "real" >> shared
echo >> shared
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> shared
echo >> shared
rm out_test
rm out_test_post

$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab  $vocab $vocab  -m  $shared_model --mini-batch 16 -i  corp/opensub.en-fr.docs.dev.en.bpe.src_prev_shuf corp/opensub.en-fr.docs.dev.en.bpe.src  > out_test
echo $n  >> shared
echo >> shared
echo "random" >> shared
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> shared
echo >> shared
rm out_test
rm out_test_post



$marian/marian-decoder  -d $dev  -n $n -b 6 -v  $vocab $vocab $vocab  -m  $shared_model --mini-batch 16 -i  corp/opensub.en-fr.docs.dev.en.bpe.src_prev_null corp/opensub.en-fr.docs.dev.en.bpe.src  > out_test
echo $n  >> shared
echo >> shared
echo "null" >> shared
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> shared
echo >> shared
rm out_test
rm out_test_post



$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab $vocab -m  $shared_tok_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev corp/opensub.en-fr.docs.dev.en.bpe.src > out_test
echo $n >> shared_tok
echo >> shared_tok
echo "real">> shared_tok
echo >> shared_tok
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> shared_tok
echo >> shared_tok
rm out_test
rm out_test_post
$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab $vocab -m  $shared_tok_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev_shuf corp/opensub.en-fr.docs.dev.en.bpe.src > out_test
echo $n >> shared_tok
echo >> shared_tok
echo "random">> shared_tok
echo >> shared_tok
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> shared_tok
echo >> shared_tok
rm out_test
rm out_test_post

$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab $vocab -m  $shared_tok_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev_null corp/opensub.en-fr.docs.dev.en.bpe.src > out_test
echo $n >> shared_tok
echo >> shared_tok
echo "null">> shared_tok
echo >> shared_tok
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> shared_tok
echo >> shared_tok
rm out_test
rm out_test_post

done
