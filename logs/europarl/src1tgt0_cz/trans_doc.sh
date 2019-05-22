moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
marian=/mnt/minerva1/nlp/projects/nmt/doc-marian-new2/doc-marian/build

for n in {6..6}
do
n=$(bc -l <<< $n/10);
echo "DOC"
doc_model=model/model.src1tgt0.from_new_pretrained.context-enc-depth1.last2.npz.best-translation.npz
moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
$marian/marian-decoder  -d 0  -n $n -b 6  -c $doc_model.decoder.yml -v corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml -m $doc_model --mini-batch 64 --maxi-batch 100 --maxi-batch-sort src -i corp/europarl.cs-en.docs.dev.en.bpe.src_prev corp/europarl.cs-en.docs.dev.en.bpe.src > out_test
echo $n >> doc
echo >> doc
echo "real" >> doc
echo >> doc

cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz >> doc
echo >> doc
rm out_test
rm out_test_post


moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
$marian/marian-decoder  -d 0  -n $n -b 6 -v corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml -m $doc_model --mini-batch 64 --maxi-batch 100 --maxi-batch-sort src  -i corp/europarl.cs-en.docs.dev.en.bpe.src_prev_shuf corp/europarl.cs-en.docs.dev.en.bpe.src > out_test
echo $n >> doc
echo >> doc
echo "random" >> doc
echo >> doc
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz >> doc
echo >> doc
rm out_test
rm out_test_post
exit

moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
$marian/marian-decoder  -d 0  -n $n -b 6 -v corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml -m  $doc_model --mini-batch 64 --maxi-batch 100 --maxi-batch-sort src   -i corp/europarl.cs-en.docs.dev.en.bpe.src_prev_null corp/europarl.cs-en.docs.dev.en.bpe.src > out_test
echo $n >> doc
echo >> doc
echo "null" >> doc
echo >> doc
cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz >> doc
echo >> doc
rm out_test
rm out_test_post

done
