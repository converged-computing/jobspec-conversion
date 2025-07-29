#!/bin/bash
#SBATCH --job-name=nodepint
#SBATCH --output=./scripts/reports/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=10:00:00

python3 ./scripts/jax_test.py
