import sys,math
with open(sys.argv[1]) as src, open(sys.argv[2]) as tgt, open(sys.argv[3]) as scores_adq_src, open(sys.argv[4]) as scores_adq_tgt, \
        open(sys.argv[5]) as scores_dom_in, open(sys.argv[6]) as scores_dom_out:
    for lineSrc,lineTgt,lineSrcAdqScore,lineTgtAdqScore,InDomScore, OutDomScore in \
            zip(src,tgt,scores_adq_src, scores_adq_tgt,scores_dom_in, scores_dom_out):
        norm_adq_src=float(lineSrcAdqScore)/(lineSrc.count(' ')+1)
        norm_adq_tgt=float(lineTgtAdqScore)/(lineTgt.count(' ')+1)
        adq=math.exp(-(abs(norm_adq_src-norm_adq_tgt)+0.5*abs(norm_adq_src+norm_adq_tgt)))
        dom= math.exp(-(float(InDomScore)/(lineTgt.count(' ')+1)-float(OutDomScore)/(lineTgt.count(' ')+1)))
        print ('\t'.join((lineSrc.strip(),lineTgt.strip(),str(adq),str(dom))))

