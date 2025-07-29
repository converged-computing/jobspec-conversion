#!/bin/bash
#SBATCH --job-name=PFN-l4
#SBATCH --output=logs/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=04:00:00
#SBATCH --partition=gpu

source tensorflow.venv/bin/activate
python pfn_train.py  --doEarlyStopping --latentSize=4 --makeROCs --label="l4" 
