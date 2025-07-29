#!/bin/bash
#SBATCH --job-name=tensorflow
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100GB
#SBATCH --partition=gpu4_medium

module purge
module load python/gpu/3.6.5
wait
python train_resnet.py 1 32 100 0
