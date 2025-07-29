#!/bin/bash
#SBATCH --job-name=class
#SBATCH --output=job_%x_%j.o
#SBATCH --error=job_%x_%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=120G
#SBATCH --time=4-10:00:00
#SBATCH --partition=gpus
#SBATCH --exclude=gpu[1601-1605]

export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'

source activate ~/miniconda3/envs/DLproject
export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'
cd ~/CSCI2470Project/Multi-caption-Diffusion/Diffusion-Models-pytorch-main
nvidia-smi
python train.py
