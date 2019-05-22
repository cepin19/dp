moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
marian=/mnt/minerva1/nlp/projects/nmt/marian-dev/build
for n in {4..29}
do
n=$(bc -l <<< $n/10);
echo $n


$marian/marian-decoder  -d 0  -n $n -b 6 -v corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml  -m  model/model.src0tgt0_to_tgt0.newbase.160.npz.best-translation.npz --mini-batch 16 -i corp/europarl.cs-en.docs.dev.en.bpe  > out_test
echo $n >> results

cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post
cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz | cut -f 3 -d ' ' | cut -f 1 -d ',' >> results
echo >> results
done
