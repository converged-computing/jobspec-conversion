#!/bin/bash
#FLUX: --job-name=nosearch
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/entailment_bank
conda activate entbank
python eval/run_scorer.py --task "task_2" --split test --prediction_file ../NLProofS/prover/lightning_logs/nosearch/results_test.tsv --output_dir ../ablation1/eval/nosearch/ --bleurt_checkpoint ../bleurt-large-512/
