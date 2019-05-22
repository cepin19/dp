import gzip,sys
doc=""
with gzip.open(sys.argv[1], 'rt', encoding='utf-8') as filtered:
    for line in filtered:
