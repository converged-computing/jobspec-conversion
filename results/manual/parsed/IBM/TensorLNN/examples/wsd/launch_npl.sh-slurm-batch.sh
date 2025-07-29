#!/bin/bash
#SBATCH --job-name=TensorLNN
#SBATCH --output=output_npl_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=00:10:00

source activate pytorch-env
srun python wsd_main.py
