#!/bin/bash
#SBATCH --job-name=zlyn
#SBATCH --output=job.%j-nvidia-smi.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --partition=gpulab02
#SBATCH --qos=gpulab02
#SBATCH --constraint=ntasks-per-node=8
#SBATCH --nodelist=gpu030

export CUDA_VISIBLE_DEVICES='0,1'

export CUDA_VISIBLE_DEVICES=0,1
nvidia-smi
