"""
Reads a file with one context sentence produced by doc2context.py, outputs two files that can be used to train a dual encoder model
"""
import sys
delim="<context>"
out_name=sys.argv[1]
with open("%s.src"%out_name,'wt') as src, open("%s.src_prev"%out_name,'wt') as src_prev:
    for line in sys.stdin:
        tabs=line.split(delim)
        src_prev.write(tabs[0].strip()+'\n')
        src.write(tabs[1].strip()+'\n')
