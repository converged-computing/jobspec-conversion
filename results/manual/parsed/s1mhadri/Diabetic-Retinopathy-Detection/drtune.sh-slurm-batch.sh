#!/bin/bash
#SBATCH --job-name=t11_wb
#SBATCH --output=dr_tune-%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00

module load cuda/11.2
python3 wandb-tune.py
