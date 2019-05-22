"""
Compares scores produced by get_score*.sh scripts. Outputs number of correct and incorrect choices by the model.
Usage: python3 compare.py correct_scores incorrect_scores
Author: Josef Jon
"""
import sys
good=0
bad=0
with open(sys.argv[1]) as correct, open(sys.argv[2]) as incorrect:
    for lineSrc,lineTgt in zip(correct,incorrect):
        if float(lineSrc)>float(lineTgt):
            good+=1
        else:
            bad+=1
print ("GOOD: %s"%good)
print("BAD %s:"%bad)
