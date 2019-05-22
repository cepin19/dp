import sys
src=['en']
tgt=['cs','sk','sl','si']
outfile=sys.argv[1]
with open('%s.langid_clean.%s'%(outfile,src[0]),'w') as srcClean,  open('%s.langid_clean.%s'%(outfile,tgt[0]),'w') as tgtClean,  open('%s.langid_bad'%(outfile),'w') as bad:
    for line in sys.stdin:
        tabs=line.strip().split('\t')
        if len(tabs)!=4:
            sys.stderr.write("CHYBA")
            sys.stderr.write(str(tabs))
            sys.stderr.write(line)
            continue
        if any(s in tabs[1] for s in src) and any(t in tabs[3] for t in tgt):
            srcClean.write(tabs[0]+' \n')
            tgtClean.write(tabs[2]+' \n')
        else:
            bad.write(line)
