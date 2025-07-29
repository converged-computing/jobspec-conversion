#!/bin/bash
#SBATCH --job-name=fairnas
#SBATCH --output=logs/%j.%x.%N.out
#SBATCH --error=logs/%j.%x.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:8
#SBATCH --time=6-00:00:00

python src/search/search.py --dataset CelebA
