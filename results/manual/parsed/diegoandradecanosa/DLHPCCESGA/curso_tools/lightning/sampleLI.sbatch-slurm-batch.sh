#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:2
#SBATCH --mem=8G
#SBATCH --time=00:59:00
#SBATCH --constraint=ntasks-per-node=2

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source $LUSTRE/mytorch/bin/activate
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
pythonint=$(which python)
srun $LUSTRE/mytorch/bin/python sampleLI.py
