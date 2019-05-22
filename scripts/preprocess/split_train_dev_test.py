import sys
number_of_docs = 0
doc = ""
fil=sys.argv[1]
corp=sys.argv[2]
with open(fil) as filtered, open("train_%s.tabs"%corp,"w") as train, open("dev_%s.tabs"%corp,"w") as dev, open("test_%s.tabs"%corp,"w") as test:
    f=dev

    for line in filtered:
        tabs = line.split("\t")
        if doc != "{}{}".format(tabs[0], tabs[1]):
            number_of_docs += 1
            doc = "{}{}".format(tabs[0], tabs[1])
        if number_of_docs == 100:
            f=test
        if number_of_docs == 200:
            f=train
        f.write(line)