#!/bin/bash
#SBATCH --job-name=cw
#SBATCH --output=sbatch_log/log_%j.out
#SBATCH --error=sbatch_log/log_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=20GB
#SBATCH --time=00:20:00

module purge
module load "languages/anaconda3/2021-3.8.8-cuda-11.1-pytorch"
    python3 src/core/train_gtzan.py --reg 0 --aug 1
