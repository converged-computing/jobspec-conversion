#!/bin/bash
#SBATCH --job-name=nodepint
#SBATCH --output=./graphpint/tests/data/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00

nvidia-smi
python3 graphpint/tests/jax_test.py
