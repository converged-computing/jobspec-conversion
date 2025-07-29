#!/bin/bash
#SBATCH --job-name=mandelbrot
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --constraint=x2680

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load mpi4py
module load python/3.6
srun --mpi=pmix mandelbrot_mpi.py
