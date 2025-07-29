#!/bin/bash
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00

module purge
source ~/.bashrc
source activate pytorch-1.7.1
python train_upp.py
