#!/bin/bash
#SBATCH --job-name=gpu-info
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load hpc-sdk
nvidia-smi > gpu.info
