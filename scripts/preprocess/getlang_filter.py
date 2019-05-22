import sys
src='en'
tgt='cz'
outfile=sys.argv[1]
with open('%s.clean.%s'%(outfile,src),'w') as srcClean,  open('%s.clean.%s'%(outfile,tgt),'w') as tgtClean,  open('%s.bad'%(outfile),'w') as bad:
    for line in sys.stdin:
        tabs=line.strip().split('\t')
        if tabs[1]==src and tabs[2]==src and tabs[4]==tgt and tabs[5]==tgt:
            srcClean.write(tabs[0]+' \n')
            tgtClean.write(tabs[3]+' \n')
        else:
            bad.write(line)