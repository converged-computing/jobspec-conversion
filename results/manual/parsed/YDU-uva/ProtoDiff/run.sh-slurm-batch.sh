#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=18
#SBATCH --cpus-per-task=1
#SBATCH --time=1-12:00:00
#SBATCH --partition=gpu

python train_1.py --gpu 0
python train_5.py --gpu 0
