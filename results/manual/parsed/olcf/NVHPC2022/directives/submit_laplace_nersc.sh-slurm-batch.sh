#!/bin/bash
#SBATCH --account=ntrain4_g
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --gpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=gpu,ntasks-per-node=1

module load PrgEnv-nvidia
module load cudatoolkit
srun ./laplace
