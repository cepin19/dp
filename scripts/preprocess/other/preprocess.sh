inputSrcFile=$1
bpe=false
dedup=true
bpeVocabSrc=encs.wmt19.bpe.vocab.en
bpeVocabTgt=encs.wmt19.bpe.vocab.cz
inputTgtFile=$2
tcsModelTgt=truecase-model.cs
OutputTgtFile=$2.done
trainBpe=false
outPrefix=$7
unprintable=true
basedir=.
removeSame=true
cleanMoses=true
OutputSrcFile=$1.done
tgtLng=$5
srcLng=$3
tgtLngIso=$6
trainTruecase=false
getlang=false
bpeModelSrc=encs.wmt19.bpe
tcsModelSrc=truecase-model.en
truecase=false
srcLngIso=$4
tokenize=true
bpeModelTgt=encs.wmt19.bpe
new_start=true

translit=true
langid=true


marian_path="/home/big_maggie/usr/marian_prometheus/marian_1.7.5/build"
moses="/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/"
nmt_scripts="/home/big_maggie/usr/nmt_scripts/"
mosesMinLen=1
mosesMaxLen=120
mosesRatio=7
#rozbaleni
#cat $1 | gzip -dc  | cut -f 3,4 > $outPrefix.$srcLng-$tgtLng.tabs

#deduplikce
if [ $dedup = true ]; then
	paste "$inputSrcFile" "$inputTgtFile" > "$basedir/$outPrefix.$srcLng-$tgtLng.tabs"
	$nmt_scripts/dedup.sh  "$basedir"/"$outPrefix"."$srcLng"-"$tgtLng".tabs > $basedir/$outPrefix.$srcLng-$tgtLng.dedup.tabs
#rozdeleni do dvou souboru
	cut -f 1 $basedir/$outPrefix.$srcLng-$tgtLng.dedup.tabs > $basedir/$outPrefix.$srcLng-$tgtLng.dedup.$srcLng.snt
	cut -f 2 $basedir/$outPrefix.$srcLng-$tgtLng.dedup.tabs > $basedir/$outPrefix.$srcLng-$tgtLng.dedup.$tgtLng.snt
	rm  $basedir/$outPrefix.$srcLng-$tgtLng.dedup.tabs
	ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.dedup.$tgtLng.snt $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step
	ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.dedup.$srcLng.snt $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
else 
	if [ $new_start = true ]; then
		ln -sf $inputSrcFile $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.snt	
		ln -sf $inputTgtFile $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.snt
		ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.snt $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
		ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.snt $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step
	fi
fi
if [ $unprintable = true ]; then
    cat $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step | perl -CSD -pe 's/\N{U+FFFD}//g' | perl -CSD -pe 's/\N{U+00AD}//g'| $moses/tokenizer/remove-non-printing-char.perl >  $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.unprint_removed
    cat $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step | perl -CSD -pe 's/\N{U+FFFD}//g' | perl -CSD -pe 's/\N{U+00AD}//g'| $moses/tokenizer/remove-non-printing-char.perl >  $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.unprint_removed
    ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.unprint_removed $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
    ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.unprint_removed $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step

fi


if [ $translit = true ]; then
    cat $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step | python3 translit.py $srcLng >  $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.translit
    cat $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step | python3 translit.py $tgtLng >  $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.translit
    ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.translit $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
    ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.translit $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step

fi


if [ $removeSame = true ]; then
	#odstraneni radku, ktere maji identickou zdrojovou i cilovou stranu
	python3 $nmt_scripts/remove_same.py  $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step
	ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step.clean_pairs $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step 
	ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step.clean_pairs $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step
fi

if [ $tokenize = true  ] ;then
	$moses/tokenizer/tokenizer.perl -l $srcLngIso -a <  $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step > $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.tok
	$moses/tokenizer/tokenizer.perl -l $tgtLngIso -a < $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step > $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.tok
        ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.tok $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
        ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.tok $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step
fi


if [ $truecase = true ]; then
	if [  $trainTruecase = true  ]; then
		$moses/recaser/train-truecaser.perl --corpus $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step --model $tcsModelSrc
		$moses/recaser/train-truecaser.perl --corpus $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step --model $tcsModelTgt

	fi
	
	$moses/recaser/truecase.perl -m $tcsModelSrc < $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step > $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.tcs
	$moses/recaser/truecase.perl -m $tcsModelTgt < $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step > $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.tcs
	ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.tcs $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
	ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.tcs $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step	
fi


if [ $cleanMoses  = true ]; then
	$moses/training/clean-corpus-n.perl -ratio $mosesRatio $basedir/$outPrefix.$srcLng-$tgtLng $srcLng.current_step $tgtLng.current_step $basedir/$outPrefix.$srcLng-$tgtLng.clean  $mosesMinLen $mosesMaxLen
	mv $basedir/$outPrefix.$srcLng-$tgtLng.clean.$srcLng.current_step $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.cln
	mv $basedir/$outPrefix.$srcLng-$tgtLng.clean.$tgtLng.current_step $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.cln
	ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.cln $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
        ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.cln $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step
fi

#identifikace jazyka
if [ $langid = true ]; then
        #osetrit pripady, kdy jsem nepouzil tokenizaci, tzn. udelat docasny tokenizovany soubor a vysledky pak pouzit pro profiltrovani netokenizovaneho, muze se hodit pri pouziti sentencepiece
        cat $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step | langid -n --line > $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.langids 
        cat $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step | langid -n --line > $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.langids 
        wait
        paste $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.langids $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.langids |  python3 $nmt_scripts/langid_filter.py $basedir/$outPrefix.$srcLng-$tgtLng $srcLng $tgtLng 
        ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.langid_clean.$srcLng $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
        ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.langid_clean.$tgtLng $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step
fi



#identifikace jazyka
if [ $getlang = true ]; then
	#osetrit pripady, kdy jsem nepouzil tokenizaci, tzn. udelat docasny tokenizovany soubor a vysledky pak pouzit pro profiltrovani netokenizovaneho, muze se hodit pri pouziti sentencepiece
	cat $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step | python /home/big_maggie/usr/nmt_scripts/get_lang.py $srcLng $tgtLng > $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.getlang &
	cat $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step | python /home/big_maggie/usr/nmt_scripts/get_lang.py $srcLng $tgtLng > $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.getlang &
	wait 
	paste $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.getlang $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.getlang |  python3 $nmt_scripts/getlang_filter_less_strict.py  $basedir/$outPrefix.$srcLng-$tgtLng $srcLng $tgtLng
	ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.getlang_clean.$srcLng $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
        ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.getlang_clean.$tgtLng $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step
fi

###!!!!!
#ln -s corpus.en-cz.getlang_clean.en $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
#ln -s corpus.en-cz.getlang_clean.cz $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step


if [ $bpe = true ]; then
	if [ $trainBpe = true ]; then
		$nmt_scripts/subword-nmt/learn_joint_bpe_and_vocab.py -i $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step -s 32000 -o $bpeModelSrc --write-vocabulary $bpeModelSrc.vocab.$srcLng $bpeModelSrc.vocab.$tgtLng

	fi
	$nmt_scripts/subword-nmt/apply_bpe.py -c $bpeModelSrc --vocabulary $bpeVocabSrc --vocabulary-threshold 25 < $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step > $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.bpe #--vocabulary vocab.en --vocabulary-threshold 25
	$nmt_scripts/subword-nmt/apply_bpe.py -c $bpeModelTgt  --vocabulary $bpeVocabTgt --vocabulary-threshold 25 < $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step  > $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.bpe
	ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.bpe $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step
        ln -sf $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.bpe $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.current_step

fi


if [ "$crossentropy" = true ]; then
	#skorovani baseline modelem
	$marian_path/marian-scorer -v $srcVocab $tgtVocab -m  $srcBaseModel --maxi-batch 1000 --maxi-batch-sort src --mini-batch 24 -t $basedir/$outPrefix.$srcLng-$tgtLng.dedup.clean.clean_pairs.getlang_clean.$srcLng.bpe  $basedir/$outPrefix.$srcLng-$tgtLng.dedup.clean.clean_pairs.getlang_clean.$tgtLng.bpe --cpu-threads 24 --max-length 100 --max-length-crop > $basedir/$outPrefix.$srcLng-$tgtLng.dedup.clean.clean_pairs.getlang_clean.$srcLng.scores

	$marian_path/marian-scorer -v $srcVocab $tgtVocab -m  $srcBaseModel --maxi-batch 1000 --maxi-batch-sort src --mini-batch 24 -t $basedir/$outPrefix.$srcLng-$tgtLng.dedup.clean.clean_pairs.getlang_clean.$tgtLng.bpe $basedir/$outPrefix.$srcLng-$tgtLng.dedup.clean.clean_pairs.getlang_clean.$srcLng.bpe  --cpu-threads 24 --max-length 100 --max-length-crop > $basedir/$outPrefix.$srcLng-$tgtLng.dedup.clean.clean_pairs.getlang_clean.$tgtLng.scores
fi


ln -sf  $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step  $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.final
ln -sf  $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.current_step  $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.final  
 
cp $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng.final $basedir/$outPrefix.$srcLng-$tgtLng.$srcLng
cp $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng.final $basedir/$outPrefix.$srcLng-$tgtLng.$tgtLng


