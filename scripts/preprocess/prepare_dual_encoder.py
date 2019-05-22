import gzip,sys
article=""
#with gzip.open(sys.argv[1],'rt', encoding='utf-8') as filtered:
with open(sys.argv[1], 'rt') as filtered:

    for line in filtered:
        tabs=line.split('\t')

        if article=="{}{}".format(tabs[0],tabs[1]):
            if tabs[2].startswith("<SKIP> "):
#                out="{}\t{}\t{}".format("<NOCONTEXT>",tabs[2].replace("<SKIP> ",""),tabs[3])

                out="{}\t{}\t{}".format(tabs[2].replace("<SKIP> ",""),tabs[2].replace("<SKIP> ",""),tabs[3])

            else:
                out="{}\t{}\t{}".format(lastline,tabs[2],tabs[3])
        else:
            article = "{}{}".format(tabs[0], tabs[1])
#            out="{}\t{}\t{}".format("<NOCONTEXT>",tabs[2],tabs[3])
            out="{}\t{}\t{}".format(tabs[2].replace("<SKIP> ",""),tabs[2].replace("<SKIP> ",""),tabs[3])

        lastline=tabs[2]
        print (out)
