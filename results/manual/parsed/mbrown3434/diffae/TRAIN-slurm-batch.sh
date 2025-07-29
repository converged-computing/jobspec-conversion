#!/bin/bash
#SBATCH --job-name=diffae
#SBATCH --account=PAS2405
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=6-16:00:00
#SBATCH --partition=gpuserial

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

set -x
source activate diffae
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
cd /users/PAS2188/brown8258/test/diffae
python run_ffhq256.py
