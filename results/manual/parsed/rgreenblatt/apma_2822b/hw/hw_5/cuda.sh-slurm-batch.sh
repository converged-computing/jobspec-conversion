#!/bin/bash
#SBATCH --output=hw_05.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:05:00
#SBATCH --partition=gpu

module load cuda/10.0.130
nvidia-smi
nvprof -f -o app.nvpf ./bin/app
