import sys
for line in sys.stdin:
    print (line.split("<context>")[-1],end='')
