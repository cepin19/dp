. ./setup.sh
$marian_home/marian-scorer -v baseline/corp/vocab.encs.yml baseline/corp/vocab.encs.yml -m  baseline/model/model_base.npz.best-translation.npz --maxi-batch 1000 --maxi-batch-sort src --mini-batch 32 -t paracrawl-release1.en-cs.langid_clean.en.bpe paracrawl-release1.en-cs.langid_clean.cs.bpe -d 0 --max-length 100 --max-length-crop > scores_adq.encs 
