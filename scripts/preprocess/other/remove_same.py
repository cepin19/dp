# remove lines with same src and tgt sentence
import sys
with open(sys.argv[1]) as src, open(sys.argv[2]) as tgt, open("%s.clean_pairs"%sys.argv[1],"w") as out_src,  open("%s.clean_pairs"%sys.argv[2],"w") as out_tgt:
	for i,(line_src,line_tgt) in enumerate(zip(src,tgt)):
		if line_src.strip()==line_tgt.strip():
			pass #sys.stderr.write("Line %s: %s"%(i,line_src))
		else:
			out_src.write(line_src)
			out_tgt.write(line_tgt)
			
		
