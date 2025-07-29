#!/bin/bash
#SBATCH --output=%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

python /home/mmylee/term-project/train-talcresnet50.py
conda deactivate
