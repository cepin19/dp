moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/
cat -  | sed 's/\@\@ //g' | $moses_home/scripts/recaser/detruecase.perl | $moses_home/scripts/tokenizer/detokenizer.perl 
