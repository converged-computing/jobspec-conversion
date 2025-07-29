#!/bin/bash
#SBATCH --output=slurm-nccl-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --exclusive
#SBATCH --constraint=gpu,ntasks-per-node=8

export NCCL_DEBUG='INFO'

module load pytorch/v1.3.1-gpu
module list
export NCCL_DEBUG=INFO
srun -u -l python test_nccl.py
