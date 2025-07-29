#!/bin/bash
#SBATCH --output=gpujob.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=16GB
#SBATCH --time=01:00:00

module purge
module load nvidia-hpc-sdk
module load gcc/8.3.0
./zorder
