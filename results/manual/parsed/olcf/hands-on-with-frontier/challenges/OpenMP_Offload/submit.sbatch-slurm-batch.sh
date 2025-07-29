#!/bin/bash
#SBATCH --job-name=mat_mul
#SBATCH --account=TRN001
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=batch

module load PrgEnv-amd
module load craype-accel-amd-gfx90a
module load openblas
srun -n1 -c1 --gpus-per-task=1 --gpu-bind=closest ./matrix_multiply
