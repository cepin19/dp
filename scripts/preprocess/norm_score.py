import sys
with open(sys.argv[1]) as src, open(sys.argv[2]) as tgt, open(sys.argv[3]) as scores:
    for lineSrc,lineTgt,lineScore in zip(src,tgt,scores):
        print ('\t'.join((lineSrc.strip(),lineTgt.strip(),lineScore.strip(),str(lineTgt.count(' ')+2),str(float(lineScore)/(lineTgt.count(' ')+2)))))

