#!/bin/bash
#SBATCH --output=output/output-%j.txt
#SBATCH --mail-user=1835928575qq@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:v100l:1
#SBATCH --mem=8000
#SBATCH --time=00:10:00
#SBATCH --exclude=cdr897

CUDA_VISIBLE_DEVICES=0 python3 train.py
