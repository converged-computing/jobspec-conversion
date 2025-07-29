#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --exclude=gpu[38-39]

python scripts/test_gpu_avail.py
