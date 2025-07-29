#!/bin/bash
#SBATCH --job-name=PrimeNet
#SBATCH --output=./Out/PrimeNet.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10GB
#SBATCH --time=8-08:00:00
#SBATCH --partition=gpu

python -u ./main.py
