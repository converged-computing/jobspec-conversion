#!/bin/bash
#SBATCH --output=final.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=32G
#SBATCH --time=00:10:00
#SBATCH --partition=gpu

module load cuda/10.0.130
module load mpi/mvapich2-2.3b_gcc
srun --mpi=pmi2 ./bin/miniFE -nx 300 -ny 300 -nz 300 &
nvidia-smi -l 1
