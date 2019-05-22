'''Does the same thing as split_sent.py, but expects the file to be uncompressed and that the columns are src_url, tgt_url, src_line, tgt_line, adq_score, dom'''
from nltk.tokenize.punkt import PunktSentenceTokenizer, PunktTrainer
import nltk.data, sys, gzip, subprocess
from collections import OrderedDict
import hashlib
train = False
doc_hashes=set()
if train:
    with gzip.open("en_corp", 'rt', encoding='utf-8') as encorp, gzip.open("de_corp", 'rt', encoding='utf-8') as decorp:
        text_en = encorp.read()
        text_de = decorp.read()

    trainer_en = PunktTrainer()
    trainer_en.INCLUDE_ALL_COLLOCS = True
    trainer_en.train(text_en)

    trainer_de = PunktTrainer()
    trainer_de.INCLUDE_ALL_COLLOCS = True
    trainer_de.train(text_de)

    tokenizer_en = PunktSentenceTokenizer(trainer_en.get_params())
    tokenizer_de = PunktSentenceTokenizer(trainer_de.get_params())
else:
    # tokenizer_en=PunktSentenceTokenizer()
    # tokenizer_de=PunktSentenceTokenizer()
    #nltk.download('punkt')
    tokenizer_en = nltk.data.load('tokenizers/punkt/english.pickle')
    tokenizer_de = nltk.data.load('tokenizers/punkt/german.pickle')

mismatch = 0
realigned=0
doc_count=0
doc=""
doc_name=""
align=False
with gzip.open(sys.argv[1],'rt', encoding='utf-8') as filtered,open("tmp.src","wt") as tmp_src, open("tmp.tgt","wt") as tmp_tgt :
    for i,line in enumerate(filtered):

        tabs = line.split('\t')
        if i==0:
            doc_name = "{}{}".format(tabs[0], tabs[1])
        if doc_name != "{}{}".format(tabs[0], tabs[1]):
            doc_count+=1
            doc=doc.strip()

            src = '\n'.join(
                [lined.split('\t')[2] if lined != '<empty_placeholder>' else ' ' for lined in doc.split('\n')]).encode()
            tgt = '\n'.join(
                [lined.split('\t')[3] if lined != '<empty_placeholder>' else ' ' for lined in doc.split('\n')]).encode()
            hash = hashlib.md5(src + tgt)

            #something went wrong, unbalanced number of sentences in src and tgt, lets try to align with hunalign
            if align:
                #print("Unaligned: %s"%doc)
                #print(line)
                #print (doc)
                #for lined in doc.split('\n'):
                #    print(lined.split('\t'))


                #tmp_src.write(src)
                #tmp_tgt.write(tgt)

                tok_src=subprocess.run(
                    ["/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/tokenizer/tokenizer.perl", "-l","en"],stdout=subprocess.PIPE,
                    input=src).stdout
                tok_tgt = subprocess.run(
                    ["/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/tokenizer/tokenizer.perl", "-l", "de"],stdout=subprocess.PIPE,
                    input=tgt).stdout


                #tcs_src=subprocess.run(
                #    ["/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/recaser/truecase.perl -m /home/large/data/models/marian/encz_exp/mtm2018/wmt.2018/model/tc.en"],
                #    encoding='utf-8', capture_output=True, input=tok_src).stdout
                #tcs_tgt=subprocess.run(
                #    ["/home/big_maggie/usr/moses20161024/mosesdecoder/scripts/recaser/truecase.perl -m /home/large/data/models/marian/encz_exp/mtm2018/wmt.2018/model/tc.de"],
                #    encoding='utf-8', capture_output=True, input=tok_tgt).stdout
                #print(tok_src)
                #print(tok_tgt)
                tmp_src.write(tok_src.decode().strip())
                tmp_tgt.write(tok_tgt.decode().strip())
                tmp_src.flush()
                tmp_tgt.flush()
                hunalign = subprocess.run(
                    ["/home/big_maggie/data/bin/hunalign", "-bisent", "-realign", "align_dict.deen", "tmp.src", "tmp.tgt" ],stdout=subprocess.PIPE,
                    ).stdout.decode().strip()
                tmp_src.seek(0)
                tmp_src.truncate()
                tmp_tgt.seek(0)
                tmp_tgt.truncate()
                # alignment in form source_id=tgt_id
                try:
                    alignment=OrderedDict((lined.split('\t')[0],lined.split('\t')[1]) for lined in hunalign.split('\n'))
                except Exception as e:
                    sys.stderr.write("Alignment error! %s"%e)
                #print(alignment)

                aligned_doc=""
                #print(doc.split('\n'))
                #print(len(doc.split('\n')))
                #for i,l in enumerate(doc.split('\n')):
                 #   print ("%s : %s"%(i,l))
                last_id=-1
                for src_id in alignment:
                    #here I should do something about non-continuous documents ((last_id+1)!=src_id)
                    skip=""
                    if int(src_id)!=last_id+1:
                        skip="<SKIP> "
                    last_id = int(src_id)

                    tgt_id=alignment[src_id]

                    try:
                        src_tabs=doc.split('\n')[int(src_id)].split('\t')
                        tgt_tabs=doc.split('\n')[int(tgt_id)].split('\t')
                    except:
                        continue
                    if src_tabs[2]=="<empty_placeholder>" or tgt_tabs[3]=="<empty_placeholder>":
                        continue
                    if src_id!=tgt_id:
                        adequacy="0"
                    else:
                        adequacy=src_tabs[4]
                    #domain score is computed for target sentence
                    aligned_doc = "{}{}\n".format(aligned_doc, '\t'.join((src_tabs[0], src_tabs[1], skip+src_tabs[2], tgt_tabs[3], adequacy, tgt_tabs[5])).strip())
                realigned+=1
                sys.stderr.write("realigned document number %s (out of %s total documents): \n%s " % (realigned, doc_count,aligned_doc))
                #sys.stderr.write("religned: %s" % aligned_doc)

                #sys.stderr.flush()
                doc=aligned_doc

            if hash.hexdigest() not in doc_hashes:
                doc_hashes.add(hash.hexdigest())
            print(doc.strip(),end='\n')

          #  print ("docend")
            doc_name="{}{}".format(tabs[0], tabs[1])
            align = False
            doc=""
        line_src = tabs[2]
        line_tgt = tabs[3]
        sent_src = tokenizer_en.tokenize(line_src)
        sent_tgt = tokenizer_de.tokenize(line_tgt)
        #pad the shorter side with newlines, we will align later
        if len(sent_src) > len(sent_tgt):
            align = True
            #print("warning1: ")
            #print(sent_src)
            #print(sent_tgt)
            for x in range(0,len(sent_src) - len(sent_tgt)):
                sent_tgt.append('<empty_placeholder>')

        elif len(sent_tgt) > len(sent_src):
            align = True
            #print("warning2: ")
            #print(sent_src)
            #print(sent_tgt)
            for x in range(0,len(sent_tgt) - len(sent_src)):
                sent_src.append('<empty_placeholder>')
        #    # different number of sentences, what now?
         #   mismatch += 1
           # sys.stderr.write("mismatch no. %s : \n Src: \n" % mismatch)
          #  sys.stderr.write("\n".join(sent_src) + "\n Tgt: \n")
           # sys.stderr.write("\n".join(sent_tgt) + "\n")


        for s_src, s_tgt in zip(sent_src, sent_tgt):
            #print ("ADDING: %s \n %s"%(s_src,s_tgt))
            doc="{}{}\n".format(doc, '\t'.join((tabs[0], tabs[1], s_src, s_tgt, tabs[4], tabs[5])).strip())

