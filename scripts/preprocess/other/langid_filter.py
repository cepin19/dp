import sys
src=[sys.argv[2]]
tgt=[sys.argv[3]]

if src==['cz']:
    src=['cs']


orig_src=src[0]
orig_tgt=tgt[0]
if src == ['cs']:
    src=['cs','sk','sl','si']

if tgt == ['cs']:
    tgt=['cs','sk','sl','si']

if src in [['sr'],['hr'],['mk'],['sl'],['bs'],['sk']]:
    src=['sr','hr','mk','sl','bs','sk']
if tgt in [['sr'],['hr'],['mk'],['sl'],['bs'],['sk']]:
    tgt=['sr','hr','mk','sl','bs','sk']




outfile=sys.argv[1]
with open('%s.langid_clean.%s'%(outfile,orig_src),'w') as srcClean,  open('%s.langid_clean.%s'%(outfile,orig_tgt),'w') as tgtClean,  open('%s.langid_bad'%(outfile),'w') as bad:
    for line in sys.stdin:
        
        tabs=line.strip().split('\t')
        if len(tabs)!=4:
            print ("BAD: %s" %line)
            continue
        if any(s in tabs[2] for s in src) and any(t in tabs[3] for t in tgt):
            srcClean.write(tabs[0]+' \n')
            tgtClean.write(tabs[1]+' \n')
        else:
            bad.write(line)
