import sys
import numpy as np

lengths = [len(line.split(' ')) for line in sys.stdin.readlines()]
print (sorted(lengths)[-10:])
if len(sys.argv)>1:
    longer=np.where(np.asarray(lengths)>int(sys.argv[1]))[0].shape[0]
    print ("number of lines longer than %s: %s (%s)"%(sys.argv[1],longer,float(longer)/len(lengths)))


