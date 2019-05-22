

/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/tokenizer/tokenizer.perl -l en -a <  disambig.cs.raw.src.src_prev > disambig.cs.raw.src.src_prev.tok
/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/tokenizer/tokenizer.perl -l en -a <  disambig.cs.raw.src.src > disambig.cs.raw.src.src.tok
/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/tokenizer/tokenizer.perl -l cs -a <  disambig.cs.raw.correct > disambig.cs.raw.correct.tok
/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/tokenizer/tokenizer.perl -l cs -a <  disambig.cs.raw.incorrect > disambig.cs.raw.incorrect.tok

/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/recaser/truecase.perl -m  /home/big_maggie/data/corp/tcs_models/truecase-model.en <  disambig.cs.raw.src.src_prev.tok > disambig.cs.raw.src.src_prev.tcs
/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/recaser/truecase.perl -m  /home/big_maggie/data/corp/tcs_models/truecase-model.en <  disambig.cs.raw.src.src.tok > disambig.cs.raw.src.src.tcs
/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/recaser/truecase.perl -m  /home/big_maggie/data/corp/tcs_models/truecase-model.cs <  disambig.cs.raw.correct.tok > disambig.cs.raw.correct.tcs
/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/recaser/truecase.perl -m  /home/big_maggie/data/corp/tcs_models/truecase-model.cs <  disambig.cs.raw.incorrect.tok > disambig.cs.raw.incorrect.tcs

/home/big_maggie/usr/nmt_scripts/subword-nmt/apply_bpe.py -c /home/large/data/models/marian/encz_exp/wmt19/encs.wmt19.bpe --vocabulary /home/large/data/models/marian/encz_exp/wmt19/encs.wmt19.bpe.vocab.en --vocabulary-threshold 25  --glossaries \<context\>  < disambig.cs.raw.src.src.tcs > disambig.cs.raw.src.src.bpe  &

/home/big_maggie/usr/nmt_scripts/subword-nmt/apply_bpe.py -c /home/large/data/models/marian/encz_exp/wmt19/encs.wmt19.bpe --vocabulary /home/large/data/models/marian/encz_exp/wmt19/encs.wmt19.bpe.vocab.en --vocabulary-threshold 25  --glossaries \<context\>  < disambig.cs.raw.src.src_prev.tcs > disambig.cs.raw.src.src_prev.bpe  &


/home/big_maggie/usr/nmt_scripts/subword-nmt/apply_bpe.py -c /home/large/data/models/marian/encz_exp/wmt19/encs.wmt19.bpe --vocabulary /home/large/data/models/marian/encz_exp/wmt19/encs.wmt19.bpe.vocab.cz --vocabulary-threshold 25  --glossaries \<context\>  < disambig.cs.raw.correct.tcs > disambig.cs.raw.correct.bpe  &

/home/big_maggie/usr/nmt_scripts/subword-nmt/apply_bpe.py -c /home/large/data/models/marian/encz_exp/wmt19/encs.wmt19.bpe --vocabulary /home/large/data/models/marian/encz_exp/wmt19/encs.wmt19.bpe.vocab.cz --vocabulary-threshold 25  --glossaries \<context\>  < disambig.cs.raw.incorrect.tcs > disambig.cs.raw.incorrect.bpe  &

