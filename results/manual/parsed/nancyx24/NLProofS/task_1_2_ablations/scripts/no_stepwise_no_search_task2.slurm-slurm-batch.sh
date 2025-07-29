#!/bin/bash
#SBATCH --job-name=no_stepwise
#SBATCH --output=no_stepwise.out
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
cd /n/fs/nlp-abiramg/NLProofS
conda activate nlproofs
cd prover
python main.py test --config cli_task2_single_shot_t5-large.yaml --ckpt_path ../../weights/task2_singleshot.ckpt
