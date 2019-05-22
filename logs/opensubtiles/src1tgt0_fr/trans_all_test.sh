dev=3
marian=/home/big_maggie/usr/marian_cosmas/marian_1.7.3/marian-dev/build
doc_marian=/home/large/data/models/marian/marian-doc/same_emb_new_gate/doc-marian/build

moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/


for n in {6..29}
do
n=$(bc -l <<< $n/10);
echo $n
concat_model=model/model.src1tgt0.newvocab.3.iter440000.npz
doc_model=model/model.src1tgt0.dual.doc.same_emb2.iter910000.npz
dual_model=model/model.src1tgt0.dual.correct.iter405000.npz

vocab=corp/vocab.encz.opensub.new.yml
echo "CONCAT"
$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab  -m  $concat_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe  > out_test
echo $n  >> concat
echo >> concat
echo "real" >> concat
echo >> concat
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> concat
echo >> concat
rm out_test
rm out_test_post

$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab  -m  $concat_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.shuf  > out_test
echo $n  >> concat
echo >> concat
echo "random" >> concat
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> concat
echo >> concat
rm out_test
rm out_test_post



$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab  -m  $concat_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.nullcontext  > out_test
echo $n  >> concat
echo >> concat
echo "null" >> concat
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> concat
echo >> concat
rm out_test
rm out_test_post




echo "DOC"

$doc_marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab $vocab -m  $doc_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev corp/opensub.en-fr.docs.dev.en.bpe.src > out_test
echo $n >> doc
echo >> doc
echo "real" >> doc
echo >> doc

cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr >> doc
echo >> doc
rm out_test
rm out_test_post


$doc_marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab $vocab -m  $doc_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev_shuf corp/opensub.en-fr.docs.dev.en.bpe.src > out_test
echo $n >> doc
echo >> doc
echo "random" >> doc
echo >> doc
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr >> doc
echo >> doc
rm out_test
rm out_test_post


$doc_marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab $vocab -m  $doc_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev_null corp/opensub.en-fr.docs.dev.en.bpe.src > out_test
echo $n >> doc
echo >> doc
echo "null" >> doc
echo >> doc
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr >> doc
echo >> doc
rm out_test
rm out_test_post


$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab $vocab -m  $dual_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev corp/opensub.en-fr.docs.dev.en.bpe.src > out_test
echo $n >> dual
echo >> dual
echo "real">> dual
echo >> dual
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> dual
echo >> dual
rm out_test
rm out_test_post
$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab $vocab -m  $dual_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev_shuf corp/opensub.en-fr.docs.dev.en.bpe.src > out_test
echo $n >> dual
echo >> dual
echo "random">> dual
echo >> dual
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> dual
echo >> dual
rm out_test
rm out_test_post

$marian/marian-decoder  -d $dev  -n $n -b 6 -v $vocab $vocab $vocab -m  $dual_model --mini-batch 16 -i corp/opensub.en-fr.docs.dev.en.bpe.src_prev_null corp/opensub.en-fr.docs.dev.en.bpe.src > out_test
echo $n >> dual
echo >> dual
echo "null">> dual
echo >> dual
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/opensub.en-fr.docs.dev.fr  >> dual
echo >> dual
rm out_test
rm out_test_post

done
