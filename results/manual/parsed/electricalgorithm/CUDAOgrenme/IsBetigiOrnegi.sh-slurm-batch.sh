#!/bin/bash
#SBATCH --job-name=print_gpu
#SBATCH --account=egitim32
#SBATCH --output=print_gpu.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --partition=akya-cuda

