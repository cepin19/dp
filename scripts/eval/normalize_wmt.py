"""
Normalizes scores produced by marian-scorer by a target sentenence token count.
Usage: python3 normalize.py
Author: Josef Jon
"""

with open("incorrect_scores","r") as incr, open("incorrect_scores.norm","w") as incw, open("correct_scores","r") as cr, open("correct_scores.norm","w") as cw, open("disambig.cs.raw.incorrect.bpe","r") as inclines, open("disambig.cs.raw.correct.bpe","r") as clines:
    #print (incr.read())
    for incScore,cScore,incLine,cLine in zip(incr,cr,inclines,clines):
        #print (incScore)
        cw.write(str(float(cScore)/(len(cLine.split(" "))+1))+'\n')
        incw.write(str(float(incScore)/(len(incLine.split(" "))+1))+'\n')

