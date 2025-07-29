#!/bin/bash
#SBATCH --job-name=darts-openmp
#SBATCH --account=courses01
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

export OMP_NUM_THREADS='24'

module swap PrgEnv-cray PrgEnv-intel 
export OMP_NUM_THREADS=24
srun --export=all -n 1 -c 24 darts-omp
