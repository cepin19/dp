import sys
for line in sys.stdin:
    print (line.split("<context>")[0].strip(),end='\n')
