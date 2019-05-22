moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
marian=/mnt/minerva1/nlp/projects/nmt/doc-marian3/build

for n in {6..6}
do
n=$(bc -l <<< $n/10);
echo "DOC"
doc_model=model/model.src1tgt0.from_new_pretrained.context-enc-depth1.newest.newgate.npz
moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
$marian/marian-decoder  --type transformer-context --context-gate  -c model/model.src1tgt0.from_new_pretrained.context-enc-depth1.newest.newgate.npz.decoder.yml -m $doc_model --mini-batch 64 -i corp/europarl.cs-en.docs.dev.en.bpe.src_prev corp/europarl.cs-en.docs.dev.en.bpe.src > out_test

cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz 
done
