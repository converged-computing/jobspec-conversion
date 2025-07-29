#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:1
#SBATCH --time=01:00:00
#SBATCH --partition=gpusmall

export DATADIR='/scratch/dac/data'
export TORCH_HOME='/scratch/dac/mvsjober/torch-cache'

module purge
module load pytorch/1.8
export DATADIR=/scratch/dac/data
export TORCH_HOME=/scratch/dac/mvsjober/torch-cache
set -xv
python3 $*
