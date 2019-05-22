'''Does the same thing as split_sent.py, but expects the file to be uncompressed and that the columns are src_url, tgt_url, src_line, tgt_line, adq_score, dom'''
from nltk.tokenize.punkt import PunktSentenceTokenizer, PunktTrainer
import nltk.data,sys,gzip

train=False
if train:
    with gzip.open("en_corp",'rt', encoding='utf-8') as encorp,gzip.open("de_corp",'rt', encoding='utf-8') as decorp:
        text_en=encorp.read()
        text_de=decorp.read()

    trainer_en = PunktTrainer()
    trainer_en.INCLUDE_ALL_COLLOCS = True
    trainer_en.train(text_en)

    trainer_de = PunktTrainer()
    trainer_de.INCLUDE_ALL_COLLOCS = True
    trainer_de.train(text_de)

    tokenizer_en = PunktSentenceTokenizer(trainer_en.get_params())
    tokenizer_de = PunktSentenceTokenizer(trainer_de.get_params())
else:
    #tokenizer_en=PunktSentenceTokenizer()
    #tokenizer_de=PunktSentenceTokenizer()
    #nltk.download('punkt')
    tokenizer_en = nltk.data.load('tokenizers/punkt/english.pickle')
    tokenizer_de = nltk.data.load('tokenizers/punkt/german.pickle')

mismatch=0
with open(sys.argv[1]) as filtered:
    for line in filtered:
        tabs=line.split('\t')
        line_src=tabs[2]
        line_tgt=tabs[3]
        sent_src=tokenizer_en.tokenize(line_src)
        sent_tgt=tokenizer_de.tokenize(line_tgt)
        if len(sent_src)!=len(sent_tgt):
            #different number of sentences, what now?
            mismatch+=1
            sys.stderr.write("mismatch no. %s : \n Src: \n"%mismatch)
            sys.stderr.write("\n".join(sent_src)+"\n Tgt: \n")
            sys.stderr.write("\n".join(sent_tgt)+"\n")


        else:
            for s_src,s_tgt in zip(sent_src,sent_tgt):
                print ('\t'.join((tabs[0],tabs[1],s_src,s_tgt,tabs[4],tabs[5])),end='')

