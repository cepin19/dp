import sys,collections,os
from lutils import prepost

delim='\t'
fn=sys.argv[1]
src=sys.argv[2]
tgt=sys.argv[3]
context_len_src=int(sys.argv[4])
context_len_tgt=int(sys.argv[5])
context_len_tgttgt=0
if len(sys.argv)>6:
    context_len_tgttgt=int(sys.argv[6])

context_src=collections.deque(maxlen=context_len_src) 
context_tgt=collections.deque(maxlen=context_len_tgt)
context_tgttgt=collections.deque(maxlen=context_len_tgttgt)

true_src=prepost.TrueCaserMoses("/home/big_maggie/data/corp/tcs_models/truecase-model.%s"%src)
true_tgt=prepost.TrueCaserMoses("/home/big_maggie/data/corp/tcs_models/truecase-model.%s"%tgt)


for i in range(context_len_src+1):
    context_src.append("")

for i in range(context_len_tgt + 1):
    context_tgt.append("")

with open(fn) as input, open("%s.%s"%(os.path.basename(fn),src),'w') as srcf, open("%s.%s"%(os.path.basename(fn),tgt),'w') as tgtf, open("%s.%s.tcs"%(os.path.basename(fn),src),'w') as srcf_tcs, open("%s.%s.tcs"%(os.path.basename(fn),tgt),'w') as tgtf_tcs :
    for line in input:
        #print (line)
        if not line.startswith("<docstart id") and not line.startswith("<docend id"):
            try:
                srcline=line.split(delim)[1].strip()
                tgtline=line.split(delim)[0].strip()
            except:
                print ("malformed line: %s"%line)
                continue
#            context_src.append(srcline)
#            context_tgt.append(tgtline)
#            context_tgttgt.append(tgtline)

            src_write=' <context> '.join([*context_tgt,*context_src,srcline])
            src_write_tcs=' <context> '.join([*[true_tgt(sent) for sent in context_tgt],*[true_src(sent) for sent in context_src],true_src(srcline)])
            tgt_write=' <context> '.join([*context_tgttgt,tgtline])
            tgt_write_tcs=' <context> '.join([*[true_tgt(sent) for sent in context_tgttgt],true_tgt(tgtline)])

#            print (src_write)
 #           srcf.write(' <context> '.join(context_tgt)+' <context> '.join(context_src)+srcline+'\n')
            srcf.write(src_write+'\n')
            tgtf.write(tgt_write+'\n')
            #tgtf.write(tgtline+'\n')
           
 

#            srcf_tcs.write(' <context> '.join([true_tgt(sent) for sent in context_tgt])+' <context> '.join([true_src(sent) for sent in context_src])+srcline+'\n')
            #tgtf_tcs.write(tgtline+'\n')
            srcf_tcs.write(src_write_tcs+'\n')
            #tgtf_tcs.write(' <context> '.join([true_tgt(sent) for sent in context_tgttgt])+tgtline+'\n')
            tgtf_tcs.write(tgt_write_tcs+'\n')

            context_src.append(srcline)
            context_tgttgt.append(tgtline)

            context_tgt.append(tgtline)

        else:
            for i in range(context_len_src+1):
                 context_src.append("")

            for i in range(context_len_tgt + 1):
                 context_tgt.append("")



