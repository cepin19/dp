import hashlib, gzip, sys

# input : file with 4 tab separated columns: src sentence, tgt sentence, adequacy score, domain score
if len(sys.argv)!=2:
    sys.stderr.write("Computes a hash of concatenated source and target senetence and map scores to the hashes. \nUsage: python3 {} FILE\ninput file: file with 4 tab separated columns: src sentence, tgt sentence, adequacy score, domain score\nOutput is written to FILE.hashscores\n".format(sys.argv[0]))
    exit(-1)

with open(sys.argv[1]) as f,  open("{}.hashscores".format(sys.argv[1]), "w") as scores:
    for line,adeq_score, dom_score in zip(f,adeq,dom):
        #print (line,adeq_score,dom_score)
        src_line,tgt_line=line.split("\t")
        hash=hashlib.md5("\t".join((src_line.strip(),tgt_line.strip())).encode("utf-8",errors="replace")).hexdigest()
        scores.write("{}\t{}\t{}\n".format(hash,adeq_score.strip(),dom_score.strip()))
