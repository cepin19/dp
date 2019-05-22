import sys
from lemmatizer import Lemmatizer
src=sys.argv[1]
tgt=sys.argv[2]
lemm_cz = Lemmatizer(src, "/home/big_maggie/usr/nmt_scripts/lgmf_%s.lex"%src, "il2", path="/home/big_maggie/usr/nmt_scripts/liblemm.so")
lemm_en = Lemmatizer(tgt, "/home/big_maggie/usr/nmt_scripts/lgmf_%s.lex"%tgt, "il2", path="/home/big_maggie/usr/nmt_scripts/liblemm.so")
#TODO: pro kazdou vetu nahradit entity, ktere vytvoril tokenizator, opet puvodnimi tokeny
for line in sys.stdin:
    #line=line.decode('utf-8')
    print ('\t'.join((str(lemm_cz.get_lang(line, 0.5, src)),str(lemm_en.get_lang(line, 0.5, tgt)))))
