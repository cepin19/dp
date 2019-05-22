import numpy,sys
same=0
diff=0
new=0
with numpy.load(sys.argv[1]) as data1, numpy.load(sys.argv[2]) as data2:
    for m in data1:
        if m not in data2:
            print ("NEW %s"%m)
            new+=1
            continue
        if numpy.array_equal(data1[m],data2[m]):
            same+=1
            print ("SAME %s"%m)
        else:
            diff+=1
            print ("DIFF %s" %m)
print ("Same {}, diff {}, new {}".format(same, diff, new))
