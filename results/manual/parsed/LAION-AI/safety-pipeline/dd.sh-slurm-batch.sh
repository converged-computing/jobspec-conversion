#!/bin/bash
#SBATCH --job-name=safetyscores
#SBATCH --output=logs/%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=8
#SBATCH --constraint=ntasks-per-node=1

python3 main.py
