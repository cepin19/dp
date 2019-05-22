moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
marian=/mnt/minerva1/nlp/projects/nmt/marian-dev/build
for n in {6..6}
do
n=$(bc -l <<< $n/10);
echo $n
echo "CONCAT"
#$marian/marian-decoder  -d 0  -n $n -b 6 -v corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml  -m  model/model.src1tgt0.concat.len160.lingea.npz.best-perplexity.npz --mini-batch 16 -i corp/europarl.cs-en.docs.dev.en.bpe  > out_test
#echo $n  >> concat
#echo >> concat
#echo "real" >> concat
#echo >> concat
#cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
#cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz  >> concat
#echo >> concat
#rm out_test
#rm out_test_post

#$marian/marian-decoder  -d 0  -n $n -b 6 -v corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml  -m  model/model.src1tgt0.concat.len160.lingea.npz.best-perplexity.npz --mini-batch 16 -i corp/europarl.cs-en.docs.dev.en.bpe.shuf  > out_test
#echo $n  >> concat
#echo >> concat
#echo "random" >> concat
#cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
#cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz  >> concat
#echo >> concat
#rm out_test
#rm out_test_post



#$marian/marian-decoder  -d 0  -n $n -b 6 -v corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml  -m  model/model.src1tgt0.concat.len160.lingea.npz.best-perplexity.npz  --mini-batch 16 -i corp/europarl.cs-en.docs.dev.en.bpe.nullcontext  > out_test
#echo $n  >> concat
#echo >> concat
#echo "null" >> concat
#cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
#cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz  >> concat
#echo >> concat
#rm out_test
#rm out_test_post




echo "DOC"
doc_model=model/model.src1tgt0.from_new_pretrained.npz.best-cross-entropy.npz
moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
marian=/mnt/minerva1/nlp/projects/nmt/doc-marian/build
$marian/marian-decoder  -d 0  -n $n -b 6 -v corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml corp/vocab.encz.opensub.new.yml -m $doc_model --mini-batch 64 --maxi-batch 100 --maxi-batch-sort src -i corp/europarl.cs-en.docs.dev.en.bpe.src_prev corp/europarl.cs-en.docs.dev.en.bpe.src > out_test
echo $n >> doc
echo >> doc
echo "real" >> doc
echo >> doc

cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz >> doc
echo >> doc
exit
rm out_test
rm out_test_post


moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
marian=/mnt/minerva1/nlp/projects/nmt/doc-marian/build
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


moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
marian=/mnt/minerva1/nlp/projects/nmt/doc-marian/build
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


#moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
#moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
#marian=/mnt/minerva1/nlp/projects/nmt/marian-dev/build
#$marian/marian-decoder  -d 0  -n $n -b 6 -v corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml -m  $doc_model  --mini-batch 16 -i corp/europarl.cs-en.docs.dev.en.bpe.src_prev corp/europarl.cs-en.docs.dev.en.bpe.src > out_test
#echo 0.$n >> dual
#echo >> dual
#echo "real">> dual
#echo >> dual
#cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
#cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz  >> dual
#echo >> dual
#rm out_test
#rm out_test_post

#moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
#moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
#marian=/mnt/minerva1/nlp/projects/nmt/marian-dev/build
#$marian/marian-decoder  -d 0  -n $n -b 6 -v corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml -m  model/model.src1tgt0.dual.notc.len80.npz --mini-batch 16 -i corp/europarl.cs-en.docs.dev.en.bpe.src_prev_shuf corp/europarl.cs-en.docs.dev.en.bpe.src > out_test
#echo 0.$n >> dual
#echo >> dual
#echo "random">> dual
#echo >> dual
#cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
#cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz  >> dual
#echo >> dual
#rm out_test
#rm out_test_post

#moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
#moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
#marian=/mnt/minerva1/nlp/projects/nmt/marian-dev/build
#$marian/marian-decoder  -d 0  -n $n -b 6 -v corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml -m  model/model.src1tgt0.dual.notc.len80.npz --mini-batch 16 -i corp/europarl.cs-en.docs.dev.en.bpe.src_prev_null corp/europarl.cs-en.docs.dev.en.bpe.src > out_test
#echo 0.$n >> dual
#echo >> dual
#echo "null">> dual
#echo >> dual
#cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
#cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz  >> dual
#echo >> dual
#rm out_test
#rm out_test_post

done

