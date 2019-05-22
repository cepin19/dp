import sys
for line in sys.stdin:
     tokens=line.strip().split(' ')
     print ("{}{}".format(' '.join([token[:-1] for token in  tokens[:-1]]),tokens[-1]))