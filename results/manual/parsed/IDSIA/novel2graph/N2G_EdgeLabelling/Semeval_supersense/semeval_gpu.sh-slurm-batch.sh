#!/bin/bash
#SBATCH --job-name=gpu_test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=12020
#SBATCH --time=04:00:00
#SBATCH --partition=debug-gpu

python Supersense_semeval.py
