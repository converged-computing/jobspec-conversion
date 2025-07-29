#!/bin/bash
#SBATCH --job-name=hc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

nvidia-smi
CUDA_LAUNCH_BLOCKING=1 python eval.py
