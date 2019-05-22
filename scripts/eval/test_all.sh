#bash src0tgt0_fr/trans_test.sh src0tgt0_fr/model/model.src0tgt0.newvocab.iter630000.npz src0tgt0_base_0.6
#bash src0tgt0_fr/trans_test.sh src0tgt0_fr/model/model.src0tgt0.newvocab.iter630000.npz src0tgt0_base_2.9 2.9

#bash src1tgt0_fr/trans_test.sh src1tgt0_fr/model/model.src1tgt0.newvocab.3.iter440000.npz src1tgt0_concat_0.6
#bash src1tgt0_fr/trans_test.sh src1tgt0_fr/model/model.src1tgt0.newvocab.3.iter440000.npz src1tgt0_concat_1.7 1.7

#bash src1tgt0_fr/trans_test_dual.sh src1tgt0_fr/model/model.src1tgt0.dual.correct.iter405000.npz src1tgt0_DE_0.6
#bash src1tgt0_fr/trans_test_dual.sh src1tgt0_fr/model/model.src1tgt0.dual.correct.iter405000.npz src1tgt0_DE_2.0 2.0

#bash src1tgt0_fr/trans_test_dual.sh src1tgt0_fr/model/model.src1tgt0.dual.shared.iter250000.npz src1tgt0_DE_shared0.6
#bash src1tgt0_fr/trans_test_dual.sh src1tgt0_fr/model/model.src1tgt0.dual.shared.iter250000.npz src1tgt0_DE_shared2.0 2.0

#bash src1tgt0_fr/trans_test_dual.sh src1tgt0_fr/model/model.src1tgt0.dual.shared.tok.iter660000.npz src1tgt0_DE_shared_tok0.6
#bash src1tgt0_fr/trans_test_dual.sh src1tgt0_fr/model/model.src1tgt0.dual.shared.tok.iter660000.npz src1tgt0_DE_shared_tok1.9 1.9



#bash src1tgt0_fr/trans_test_doc.sh src1tgt0_fr/model/model.src1tgt0.doc.new.spider.prevgate.iter45000.npz src1tgt0_CE_nogate_0.6
#bash src1tgt0_fr/trans_test_doc.sh src1tgt0_fr/model/model.src1tgt0.doc.new.spider.prevgate.iter45000.npz src1tgt0_CE_nogate_2.9 2.9

#bash src1tgt1_fr/trans_test.sh src1tgt1_fr/model/model.src1tgt1.len165.iter345000.npz src1tgt1_ref0.6
#bash src1tgt1_fr/trans_test.sh src1tgt1_fr/model/model.src1tgt1.len165.iter345000.npz src1tgt1_ref_1.0 1.0

#bash src1tgt1_fr/trans_test_ownref.sh src1tgt1_fr/model/model.src1tgt1.len165.iter345000.npz src1tgt1_mt0.6
#bash src1tgt1_fr/trans_test_ownref.sh src1tgt1_fr/model/model.src1tgt1.len165.iter345000.npz src1tgt1_mt_1.5 1.5



#python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_2.9 out_test_post_src1tgt0_concat_1.7 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt0_concat_1.7_bootstrap

#python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_2.9 out_test_post_src1tgt0_DE_2.0 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt0_DE_2.0_bootstrap

python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_2.9 out_test_post_src1tgt0_DE_shared2.0 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt0_DE_shared_2.0_bootstrap

#python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_2.9 out_test_post_src1tgt0_DE_shared_tok1.9 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt0_DE_shared_tok_1.9_bootstrap

#python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_2.9 out_test_post_src1tgt0_CE_nogate_2.9 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt0_CE_nogate_2.9_bootstrap

python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_2.9 out_test_post_src1tgt1_ref_1.0 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt1_ref_1.0_bootstrap


python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_2.9 out_test_post_src1tgt1_mt_1.5 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt1_mt_1.5_bootstrap




#python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_0.6 out_test_post_src1tgt0_concat_0.6 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt0_concat_0.6_bootstrap

#python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_0.6 out_test_post_src1tgt0_DE_0.6 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt0_DE_0.6_bootstrap

python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_0.6 out_test_post_src1tgt0_DE_shared0.6 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt0_DE_shared_0.6_bootstrap

exit

python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_0.6 out_test_post_src1tgt0_DE_shared_tok0.6 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt0_DE_shared_tok_0.6_bootstrap

python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_0.6 out_test_post_src1tgt0_CE_nogate_0.6 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt0_CE_nogate_0.6_bootstrap

python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_0.6 out_test_post_src1tgt1_ref0.6 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt1_ref_0.6_bootstrap

python3 bootstrap_par.py opensub.en-fr.docs.test.fr.detok out_test_post_src0tgt0_base_0.6 out_test_post_src1tgt1_mt0.6 --eval_type bleu_detok --num_samples 10000 -c 32 > out_test_post_src1tgt1_mt_0.6_bootstrap


