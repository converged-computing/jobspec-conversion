#!/bin/bash
#SBATCH --job-name=ieneurips
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1

hostname
nvidia-smi --query-gpu=gpu_name,memory.total,memory.free --format=csv
source env/bin/activate
echo 'env started'
time python3 nlp.py
echo 'done'
