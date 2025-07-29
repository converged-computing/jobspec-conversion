#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

module load 2022
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
python -u blur-images.py
