#!/bin/bash
#SBATCH --job-name=clip
#SBATCH --output=/export/home2/zonglin001/Out/clip_2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --nodelist=node10

python -u ./main.py
