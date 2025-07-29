#!/bin/bash
#SBATCH --job-name=job1
#SBATCH --output=test_mm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=128GB
#SBATCH --time=1-00:00:00

CUDA_HOME=/usr/local/cuda
CUDA_VISIBLE_DEVICES=1
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
nvcc --version
nvidia-smi
python kd.py
