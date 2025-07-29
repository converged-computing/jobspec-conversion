#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=test_out.txt
#SBATCH --error=test_err.txt
#SBATCH --mail-user=selma.gudmundsen@gmail.com
#SBATCH --mail-type=All
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=vgpu

conda activate env1
python cifar10.py
