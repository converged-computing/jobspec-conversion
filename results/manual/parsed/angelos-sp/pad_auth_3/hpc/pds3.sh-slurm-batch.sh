#!/bin/bash
#SBATCH --job-name=nlm_gpu
#SBATCH --output=durations.stdout
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --partition=gpu

module load gcc
module load cuda/10.1.243
make clean
make all
./nlm-serial
./nlm-cuda
./nlm-cuda-shared
make clean
