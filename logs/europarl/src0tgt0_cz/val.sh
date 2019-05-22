#!/bin/bash
#echo "Validating..."

moses_home=/mnt/minerva1/nlp/projects/nmt/moses-scripts/scripts
date=`date +"%d_%m_%Y_%H:%M"`

cat $1 | sed 's/\@\@ //g' | $moses_home/recaser/detruecase.perl | $moses_home/tokenizer/detokenizer.perl > data/output.postprocessed_dev.$date


cat data/output.postprocessed_dev.$date |python3 -m sacrebleu corp/europarl.cs-en.docs.dev.cz | cut -f 3 -d ' ' | cut -f 1 -d ','
