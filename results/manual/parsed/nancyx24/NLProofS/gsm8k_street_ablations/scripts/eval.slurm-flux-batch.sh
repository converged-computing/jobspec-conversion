#!/bin/bash
#FLUX: --job-name=eval_scone
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/entailment_bank
conda activate entbank
python eval/run_scorer_scone_gsm8.py --task "scone" --split test --prediction_file "../NLProofS/prover/lightning_logs/ent_prover_ent_verifier_scone_test/results_test.tsv" --output_dir ../ablation3/eval/ent_prover_ent_verifier_scone/ --bleurt_checkpoint ../bleurt-large-512/
