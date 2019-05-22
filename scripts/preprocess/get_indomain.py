import sys
doc=""
number_of_lines = 1
score=0
avg=0
threshold=float(sys.argv[2])
doc_content=""
with open(sys.argv[1]) as splitted_sentences:
    for line in splitted_sentences:
        tabs = line.split("\t")
        doc_content+=line
        if doc != "{}{}".format(tabs[0], tabs[1]):
            avg=score / number_of_lines
            sys.stderr.write("{} average: {}/{}={} \n".format(doc,str(score),str(number_of_lines),str(avg)))
            doc = "{}{}".format(tabs[0], tabs[1])
            if avg>threshold:
                print (doc_content,end='')
            doc_content=""
            number_of_lines=0
            score=0
        score+=float(tabs[-1].strip())
        number_of_lines+=1