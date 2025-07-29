#!/bin/bash
#SBATCH --job-name=train-cgpu
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --exclusive
#SBATCH --constraint=gpu,ntasks-per-node=8

module load pytorch/v1.5.1-gpu
srun -l -u python train.py -d nccl --rank-gpu $@
