#!/bin/bash
#echo "Validating..."

dev_ref=corp/newstest2016-encs-src.en.bpe.tcs
moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
date=`date +"%d_%m_%Y_%H:%M"`

cat $1 | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > data/output.postprocessed_dev.$date


cat data/output.postprocessed_dev.$date | python3.6 gettgt0.py | python3.6 /home/big_maggie/usr/sacrebleu/sacrebleu.py corp/europarl.fr-en.docs.dev.fr0 | cut -f 3 -d ' ' | cut -f 1 -d ','
