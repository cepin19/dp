"""
Converts output of uplug-readalign into a parallel corpus with aligned lines.
Splits the corpus into dev/train/test sets.
Usage: python3 readalign_to_docs.py infile dev_docs test_docs min_len
Author: Josef Jon
"""
import sys
lastI=0
minI=0
dev_docs=int(sys.argv[2])
test_docs=int(sys.argv[3])
fn=sys.argv[1]
#if len(sys.argv)>1:
minI=int(sys.argv[4])
doc=""
num_docs=0
lasttype = ""
with open(fn) as infile, open("%s.dev"%fn,"w") as dev, open("%s.test"%fn,"w") as test,open("%s.train"%fn,"w") as train:
    for line in infile:

        if line.startswith("#") and doc!="":
            if lastI > minI:
                if num_docs<=dev_docs:
                    dev.write("<docstart id=%s>\n"%num_docs+doc+"\n<docend id=%s>\n"%num_docs)
                elif num_docs<=dev_docs+test_docs:
                    test.write("<docstart id=%s>\n"%num_docs+doc+"\n<docend id=%s>\n"%num_docs)
                else:
                    train.write("<docstart id=%s>\n"%num_docs+doc+"\n<docend id=%s>\n"%num_docs)
                num_docs+=1


                #print(doc)

            lastI = 0
            doc = ""
    #        print ("/new doc/")

        if not (line.startswith("(src)=") or line.startswith("(trg)=")):
            pass
        else:
            i=int(line[line.find('"')+1:(line.find('"', int(line.find('"')) + 1))])
            if line.startswith("(src)="):
                if lasttype=="src":
                    doc="{} {}".format(doc.strip(),line.strip()[line.find('"', int(line.find('"')) + 1)+3:])

                else:
                    doc="{}\n{}".format(doc.strip(),line.strip()[line.find('"', int(line.find('"')) + 1)+3:])

                lastI=i
                lasttype="src"
            if line.startswith("(trg)="):
                if lasttype=="trg":
                    doc="{} {}".format(doc.strip(),line.strip()[line.find('"', int(line.find('"')) + 1)+3:])
                else:
                    doc="{}\t{}".format(doc.strip(),line.strip()[line.find('"', int(line.find('"')) + 1)+3:])
                lasttype="trg"




