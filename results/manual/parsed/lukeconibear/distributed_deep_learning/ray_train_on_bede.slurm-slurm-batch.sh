#!/bin/bash
#SBATCH --account=bdlds01
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:01:00
#SBATCH --partition=gpu

export SLURM_EXPORT_ENV='ALL'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib'

export SLURM_EXPORT_ENV=ALL
source activate pytorch_bede
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib
nvidia-smi
python test_if_gpu_available_pytorch.py
