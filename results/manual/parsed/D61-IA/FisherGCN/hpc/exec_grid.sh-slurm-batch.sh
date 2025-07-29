#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:59:59
#SBATCH --constraint=ntasks-per-node=1

module load tensorflow/1.14.0-py36-gpu
python3 scripts/benchmark_grid.py $@
