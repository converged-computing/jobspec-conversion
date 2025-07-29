#!/bin/bash
#SBATCH --job-name=stepwise_no_search_task_2
#SBATCH --output=stepwise_no_search_task_2.out
#SBATCH --mail-user=nancyx@princeton.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a5000:1
#SBATCH --mem=16G
#SBATCH --time=08:00:00

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/NLProofS
conda activate nlproofs
cd prover
python main.py test --config cli_task2_stepwise_t5-large.yaml --ckpt_path ../../weights/task2_stepwise.ckpt --model.proof_search false
