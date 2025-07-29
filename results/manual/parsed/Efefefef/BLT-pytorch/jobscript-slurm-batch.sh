#!/bin/bash
#SBATCH --output=ecoset_multi_output.o%j
#SBATCH --error=ecoset_multi_error.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=9
#SBATCH --gres=gpu:H100.80gb:1
#SBATCH --partition=klab-gpu

echo "running in shell: " "$SHELL"
spack load cuda@11.8.0
spack load cudnn@8.6.0.163-11.8
spack load miniconda3
eval "$(conda shell.bash hook)"
conda activate h100
python train.py
