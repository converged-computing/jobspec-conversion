#!/bin/bash
#SBATCH --job-name=IOD-train-mlp
#SBATCH --account=m2621
#SBATCH --output=IOD-train-mlp.%j.out
#SBATCH --error=IOD-train-mlp.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gpus-per-task=4
#SBATCH --time=12:00:00
#SBATCH --partition=regular
#SBATCH --constraint=gpu,ntasks-per-node=1

export MPICH_GPU_SUPPORT_ENABLED='0'

module load tensorflow
module list
set -x
export MPICH_GPU_SUPPORT_ENABLED=0
srun -l -u python ./IOD-train-mlp.py
