#!/bin/bash
#SBATCH --job-name=pytorch_primary
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:4
#SBATCH --mem=0
#SBATCH --time=20-20:00:00
#SBATCH --constraint=ntasks-per-node=4

srun python train.py
