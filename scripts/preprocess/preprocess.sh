export moses_home=/home/big_maggie/usr/moses20161024/mosesdecoder/ 
#paste paracrawl-release1.en en.langids paracrawl-release1.cs cs.langids > paracrawl-release1.en-cs.langid_tabs
#cat paracrawl-release1.en-cs.langid_tabs | python3 langid_filter.py paracrawl-release1.en-cs.langid_clean
$moses_home/scripts/tokenizer/tokenizer.perl -l cs < paracrawl-release1.en-cs.langid_clean.cs > paracrawl-release1.en-cs.langid_clean.cs.tok
$moses_home/scripts/tokenizer/tokenizer.perl -l en < paracrawl-release1.en-cs.langid_clean.en > paracrawl-release1.en-cs.langid_clean.en.tok
$moses_home/scripts/recaser/truecase.perl -m truecase-model.en < paracrawl-release1.en-cs.langid_clean.en.tok > paracrawl-release1.en-cs.langid_clean.en.tcs
$moses_home/scripts/recaser/truecase.perl -m truecase-model.cs < paracrawl-release1.en-cs.langid_clean.cs.tok > paracrawl-release1.en-cs.langid_clean.cs.tcs
/home/big_maggie/data/models/nematus/models/subword-nmt/apply_bpe.py -c ../lexonly/corp/encz_hq.lex.bpe --vocabulary  ../lexonly/corp/vocab.en   --vocabulary-threshold 25 <  paracrawl-release1.en-cs.langid_clean.en.tcs > paracrawl-release1.en-cs.langid_clean.en.bpe &
/home/big_maggie/data/models/nematus/models/subword-nmt/apply_bpe.py -c ../lexonly/corp/encz_hq.lex.bpe --vocabulary  ../lexonly/corp/vocab.cs   --vocabulary-threshold 25 <  paracrawl-release1.en-cs.langid_clean.cs.tcs > paracrawl-release1.en-cs.langid_clean.cs.bpe &


#for file in *en*part*langids
#do
#echo $file
#/home/big_maggie/usr/subword-nmt/apply_bpe.py -c ../lexonly/corp/encz_hq.lex.bpe --vocabulary ../lexonly/corp/vocab.en --vocabulary-threshold 25 < $file > $file.bpe
#done

#for file in *cs*part*langids
#do
#echo $file
#/home/big_maggie/usr/subword-nmt/apply_bpe.py -c ../lexonly/corp/encz_hq.lex.bpe --vocabulary ../lexonly/corp/vocab.cs --vocabulary-threshold 25 < $file > $file.bpe
#done

