#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=400M
#SBATCH --time=00:10:00
#SBATCH --partition=gpuq

python testTF2.py
