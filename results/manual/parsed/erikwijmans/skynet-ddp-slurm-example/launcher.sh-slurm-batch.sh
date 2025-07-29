#!/bin/bash
#SBATCH --job-name=cifar10-ddp
#SBATCH --output=logs.out
#SBATCH --error=logs.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --constraint=ntasks-per-node=2

export MASTER_ADDR='$(srun --ntasks=1 hostname 2>&1 | tail -n1)'

export MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
set -x
srun -u python -u -m ddp_example.train_cifar10
