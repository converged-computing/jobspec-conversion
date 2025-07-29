#!/bin/bash
#SBATCH --output=slurm-nccl-shifter-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --exclusive
#SBATCH --constraint=gpu,ntasks-per-node=8

export NCCL_DEBUG='INFO'

singularity
exec
registry.services.nersc.gov/wbhimji/nvidia-pytorch:19.12-py3
export NCCL_DEBUG=INFO
srun -u -l shifter python test_nccl.py
