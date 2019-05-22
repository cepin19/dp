import sys
doc=""
number_of_lines = 1
length=0
avg=0
threshold=9
doc_content=""
with open(sys.argv[1]) as splitted_sentences:
    for line in splitted_sentences:
        tabs = line.split("\t")
        if len(tabs)!=6:
            sys.stderr.write("WRONG NUMBER OF TABS (%s): %s"%(len(tabs),line))
            continue
        doc_content+=line
        if doc != "{}{}".format(tabs[0], tabs[1]):
            avg=length / number_of_lines
            sys.stderr.write("{} average: {}/{}={} \n".format(doc,str(length),str(number_of_lines),str(avg)))
            doc = "{}{}".format(tabs[0], tabs[1])
            length=0
            number_of_lines=0
            if avg>threshold:
                print (doc_content,end='')
            doc_content=""

        length+=len("{} {}".format(tabs[2],tabs[3]).split(" "))
        number_of_lines+=1