moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
/home/big_maggie/usr/marian_prometheus/marian_1.7.5/marian-dev/build/marian-decoder --max-length 160 -d 1  -n 0.6 -b 6 -v corp/vocab.enfr.europarl.yml corp/vocab.enfr.europarl.yml -m  model/model.src1tgt0_to_tgt1.concat.iter60000.npz --mini-batch 64 -i corp/europarl.fr-en.docs.dev.en.bpe > out_test

cat out_test | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > out_test_post


cat out_test_post | python3 gettgt0.py | python3 /home/big_maggie/usr/sacrebleu/sacrebleu.py corp/europarl.fr-en.docs.dev.fr0 | cut -f 3 -d ' ' | cut -f 1 -d ','
cat out_test_post | python3 gettgt.py | python3 /home/big_maggie/usr/sacrebleu/sacrebleu.py corp/europarl.fr-en.docs.dev.fr1 | cut -f 3 -d ' ' | cut -f 1 -d ','

