moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
marian=/mnt/minerva1/nlp/projects/nmt/marian-dev/build
$marian/marian-decoder  -d 0  -n $1 -b 6 -v corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml corp/vocab.encs.europarl.yml -m  model/model.src1tgt0.dual.notc.len80.npz --mini-batch 16 -i corp/europarl.cs-en.docs.test.en.bpe.src_prev corp/europarl.cs-en.docs.test.en.bpe.src > out_test

cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post


cat out_test_post | python3 -m sacrebleu corp/europarl.cs-en.docs.test.cz | cut -f 3 -d ' ' | cut -f 1 -d ','

