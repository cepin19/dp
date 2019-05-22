import gzip
original_articles=set()
filtered_articles=set()
with gzip.open("big_hashes.gz",'rt', encoding='utf-8') as unfiltered,  gzip.open("big_hashes.filtered-2.gz",'rt', encoding='utf-8') as filtered:
    for i, line in enumerate(filtered):
        filtered_articles.add("%s%s" % (line.split('\t')[0], line.split('\t')[1]))
        if i == 1000000:
            last = "%s%s" % (line.split('\t')[0], line.split('\t')[1])
            print (last)
            break
    for i, line in enumerate(unfiltered):
        original_articles.add("%s%s"%(line.split('\t')[0],line.split('\t')[1]))
        #print ("%s%s" % (line.split('\t')[1], line.split('\t')[2]))
        if "%s%s" % (line.split('\t')[1], line.split('\t')[2])==last:
            print (last)
            print (i)
            break

