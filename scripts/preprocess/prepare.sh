mkdir baseline
mkdir baseline/corp
cd baseline/corp
wget http://data.statmt.org/wmt18/translation-task/preprocessed/cs-en/corpus.gz
gzip -d  corpus.gz

mkdir opensub
wget http://opus.nlpl.eu/download.php?f=OpenSubtitles2018/cs-en.xml.gz

# preprocess - tokenize, langid, train truecaser, truecase, train BPE model, apply BPE, create shared vocab
# train baseline models in both directions



# train LM on news commentary and webidnes
# cd LM/news; ./preprocess.sh;  ./train.sh

# train LM on randomly sampled 1M lines
# cd LM/paracrawl; ./preprocess.sh;  ./train.sh

bash score_encs.sh
bash score_csen.sh
bash score_news.lm.sh
bash score_paracrawl.lm.sh
