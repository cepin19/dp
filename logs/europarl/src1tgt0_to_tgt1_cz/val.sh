#!/bin/bash
#echo "Validating..."

dev_ref=corp/newstest2016-encs-src.en.bpe.tcs
moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/
date=`date +"%d_%m_%Y_%H:%M"`

cat $1 | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl > data/output.postprocessed_dev.$date


cat data/output.postprocessed_dev.$date | python3 gettgt.py |  $moses_home/scripts/recaser/detruecase.perl  | python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz2 | cut -f 3 -d ' ' | cut -f 1 -d ','
