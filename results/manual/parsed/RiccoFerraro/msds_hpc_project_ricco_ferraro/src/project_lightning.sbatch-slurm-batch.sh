#!/bin/bash
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --partition=gpgpu-1
#SBATCH --constraint=ntasks-per-node=1

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source project_venv/bin/activate
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
module load cuda
srun -v python -u src/project_lightning.py --num_nodes=1 --num_devices=8
