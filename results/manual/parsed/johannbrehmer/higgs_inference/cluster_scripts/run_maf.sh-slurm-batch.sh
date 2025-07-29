#!/bin/bash
#SBATCH --job-name=higgsmaf
#SBATCH --output=slurm_maf.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=128GB
#SBATCH --time=7-00:00:00

source activate goldmine
cd /home/jb6504/higgs_inference/higgs_inference
python -u experiments.py maf -o short
