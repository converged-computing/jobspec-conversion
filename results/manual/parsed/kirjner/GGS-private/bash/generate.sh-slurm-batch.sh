#!/bin/bash
#SBATCH --job-name=generate
#SBATCH --output=logs/generate/Diagonal-unsmoothed_%j.out
#SBATCH --error=logs/generate/Diagonal-unsmoothed_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:1
#SBATCH --mem=32GB
#SBATCH --time=1-00:00:00
#SBATCH --array=1-5

python ggs/GWG.py experiment=generate/Diagonal-unsmoothed run.seed=$SLURM_ARRAY_TASK_ID 
