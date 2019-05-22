import sys
src=sys.argv[2]
tgt=sys.argv[3]
outfile=sys.argv[1]
with open('%s.getlang_clean.%s'%(outfile,src),'w') as srcClean,  open('%s.getlang_clean.%s'%(outfile,tgt),'w') as tgtClean,  open('%s.getlang_bad'%(outfile),'w') as bad:
    for line in sys.stdin:
        tabs=line.strip().split('\t')
        if len(tabs)<6: 
            print ("error!: %s"%line)
            continue
        if (tabs[1]==src or tabs[2]==src) and (tabs[5]==tgt or tabs[4]==tgt):
            srcClean.write(tabs[0]+' \n')
            tgtClean.write(tabs[3]+' \n')
        else:
            bad.write(line)
