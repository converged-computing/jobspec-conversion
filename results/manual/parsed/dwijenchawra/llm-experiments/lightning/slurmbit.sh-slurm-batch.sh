#!/bin/bash
#SBATCH --job-name=twonodellm
#SBATCH --account=euge-k
#SBATCH --output=slurmout/%x-%j.out
#SBATCH --error=slurmout/%x-%j.err
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:2
#SBATCH --time=02:00:00
#SBATCH --partition=gilbreth-k
#SBATCH --constraint=ntasks-per-node=2

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export NCCL_SOCKET_IFNAME='ib'

mamba activate ml
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export NCCL_SOCKET_IFNAME="ib"
module load cuda/12.1.0
srun python dollyv2modules.py
