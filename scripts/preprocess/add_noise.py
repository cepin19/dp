import sys,random
with open(sys.argv[1]) as inF:
    for line in inF:
        tokens=line.split(' ')
        new=[]
        for i,t in enumerate(tokens):
            if random.random()>0.9:
                #delete token
                continue
            if random.random() > 0.9:
                new.append("<FILL>")
                continue
            new.append(t)
        print (' '.join(new).strip())
