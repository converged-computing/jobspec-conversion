#!/bin/bash
#SBATCH --job-name=Latte-ffs
#SBATCH --output=slurm_log/%j.out
#SBATCH --error=slurm_log/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:8
#SBATCH --time=20-20:00:00
#SBATCH --partition=group-name
#SBATCH --constraint=ntasks-per-node=8

source ~/.bashrc
conda activate latte
srun python train.py --config ./configs/sky/sky_train.yaml
