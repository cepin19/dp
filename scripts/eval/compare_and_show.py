"""
Compares cross-entropy scores produced by get_score*.sh scripts. Prints translations chosen by the model. Computes accuracy.
Usage: python3 compare_and_show.py correct_scores incorrect_scores
Author: Josef Jon
"""
import sys
good=0
bad=0
with open(sys.argv[1]) as correct, open(sys.argv[2]) as incorrect, open(sys.argv[3]) as src, open(sys.argv[4]) as correctTxt, open(sys.argv[5]) as incorrectTxt:
    for lineSrc,lineTgt,srcLine,correctLine,incorrectLine in zip(correct,incorrect,src,correctTxt,incorrectTxt):
        if float(lineSrc)>float(lineTgt):
            good+=1
            print(srcLine)
            print (correctLine)
        else:
            bad+=1
            print(srcLine)
            print (incorrectLine)

print ("GOOD: %s"%good)
print("BAD %s:"%bad)
print ("ACC: %s"%(float(good)/(good+bad)))
