#!/bin/bash
#SBATCH --account=m3623
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=80
#SBATCH --gres=gpu:8
#SBATCH --time=04:00:00
#SBATCH --exclusive
#SBATCH --constraint=gpu

module load pytorch/v1.5.0-gpu
srun python train.py ./config.yaml explicit_G512
date
