#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:15:00

source ~/.bashrc
source $PREAMBLE
conda activate wb
srun --mpi=pmix "$@"
