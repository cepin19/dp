"""
Reads the discourse test sets in JSON format. Converts the test set into a format expected by a concatencation model. 
Performs tokenization, truecasing and BPE splitting.
Usage: python3 eval.py
Author: Josef Jon
"""
import json,subprocess
from lutils import prepost
src="en"
tgt="cs"
marian_path=""

#set desired context, now src1tgt0 to tgt0
src_src_context=1
src_tgt_context=0
tgt_tgt_context=0

#en-fr
#basename="coherence-cohesion"

#en-cs
basename="disambig.cs"

#load tokenizers, truecasers and bpe models
tok_src=prepost.Tokenizer(src+" -a -no-escape")
tok_tgt=prepost.Tokenizer(tgt+" -a -no-escape")
true_src=prepost.TrueCaserMoses("/home/big_maggie/data/corp/tcs_models/truecase-model.%s"%src)
true_tgt=prepost.TrueCaserMoses("/home/big_maggie/data/corp/tcs_models/truecase-model.%s"%tgt)
examples=[]
bpe_src_opensub=prepost.Segmentator("enfr.opensub.bpe")
bpe_tgt_opensub=prepost.Segmentator("enfr.opensub.bpe")
bpe_src_europarl=prepost.Segmentator("enfr.europarl.bpe")
bpe_tgt_europarl=prepost.Segmentator("enfr.europarl.bpe")

bpe_src_opensub=prepost.Segmentator("encs.opensub.bpe")
bpe_tgt_opensub=prepost.Segmentator("encs.opensub.bpe")
bpe_src_europarl=prepost.Segmentator("encs.europarl.bpe")
bpe_tgt_europarl=prepost.Segmentator("encs.europarl.bpe")


def preprocess(line,dir):
    if dir=="src":
        return (bpe_src_europarl(true_src(tok_src(line))),bpe_src_opensub(true_src(tok_src(line))))
    else:
        return (bpe_tgt_europarl(true_tgt(tok_tgt(line))),bpe_tgt_opensub(true_tgt(tok_tgt(line))))
def score(config,src,correct,incorrect):
    subprocess.call("{0}/marian-scorer -c {1} -t {2} {3}".format(marian_path,config,src,correct))
    subprocess.call("{0}/marian-scorer -c {1} -t {2} {3}".format(marian_path,config,src,incorrect))

with open("%s.json"%basename) as cctest,open("%s.raw.src"%basename,"w") as srcRaw, open("%s.europarl.src"%basename,"w") as srcEuroparl,open("%s.opensub.src"%basename,"w") as srcOpensub,  open("%s.europarl.src1tgt1"%basename,"w") as src1tgt1Europarl,open("%s.opensub.src1tgt1"%basename,"w") as src1tgt1Opensub,  open("%s.europarl.nocontext.src"%basename,"w") as srcEuroparlNoC,open("%s.opensub.nocontext.src"%basename,"w") as srcOpensubNoC,  open("%s.europarl.correct"%basename,"w") as correctEuroparl,open("%s.opensub.correct"%basename,"w") as correctOpensub, open("%s.europarl.incorrect"%basename,"w") as incorrectEuroparl, open("%s.opensub.incorrect"%basename,"w") as incorrectOpensub, open("%s.raw.correct"%basename,"w") as correctRaw, open("%s.raw.incorrect"%basename,"w") as incorrectRaw:
    ccexamples=json.load(cctest)
    for i in ccexamples:
        print("Example %s:\n"%i)
        print (ccexamples[i])
        if "type" in ccexamples[i]:
            type=ccexamples[i]["type"]
        else:
            type="unk"
        for example in ccexamples[i]["examples"]:
            #print(example)
            #print (example["src"])
            #print (example["trg"]["incorrect"])
            #print (example["trg"]["correct"])
            #srcText=#tuple (europarl, opensub), different BPE
	    #TODO tgt context
            if type=="disambig":
                srcEuroparl.write(" <context> ".join([preprocess(example["src"][0],"src")[0], preprocess(example["src"][1],"src")[0]])+'\n')
#            srcOpensub.write(" <context> ".join([preprocess(example["src"][i],"src")[1] for i in range(0,src_src_context+1)])+'\n')
                srcOpensub.write(" <context> ".join([preprocess(example["src"][0],"src")[1], preprocess(example["src"][1],"src")[1]])+'\n')
                srcRaw.write(" <context> ".join([example["src"][0], example["src"][1]])+'\n')

                src1tgt1Europarl.write(" <context> ".join([preprocess(example["trg"]["correct"][0],"tgt")[0],preprocess(example["src"][0],"src")[0], preprocess(example["src"][1],"src")[0]])+'\n')
                src1tgt1Opensub.write(" <context> ".join([preprocess(example["trg"]["correct"][0],"tgt")[1],preprocess(example["src"][0],"src")[1], preprocess(example["src"][1],"src")[1]])+'\n')

                srcOpensubNoC.write(preprocess(example["src"][1],"src")[1]+'\n')
                srcEuroparlNoC.write(preprocess(example["src"][1],"src")[0]+'\n')


                incorrectEuroparl.write(preprocess(example["trg"]["incorrect"][1],"tgt")[0]+'\n')
                incorrectOpensub.write(preprocess(example["trg"]["incorrect"][1],"tgt")[1]+'\n')
                incorrectRaw.write(example["trg"]["incorrect"][1]+'\n')

                correctEuroparl.write(preprocess(example["trg"]["correct"][1],"tgt")[0]+'\n')
                correctOpensub.write(preprocess(example["trg"]["correct"][1],"tgt")[1]+'\n')
                correctRaw.write(example["trg"]["correct"][1]+'\n')


        examples.append(type)
