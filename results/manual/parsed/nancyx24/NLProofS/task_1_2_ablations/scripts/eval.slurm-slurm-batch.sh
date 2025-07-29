#!/bin/bash
#SBATCH --job-name=nosearch
#SBATCH --output=../eval/nosearch.out
#SBATCH --mail-user=abiramg@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a5000:1
#SBATCH --mem=16G
#SBATCH --time=08:00:00

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/entailment_bank
conda activate entbank
python eval/run_scorer.py --task "task_2" --split test --prediction_file ../NLProofS/prover/lightning_logs/nosearch/results_test.tsv --output_dir ../ablation1/eval/nosearch/ --bleurt_checkpoint ../bleurt-large-512/
