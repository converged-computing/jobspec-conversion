#!/bin/bash
#SBATCH --account=cc-debug
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=00:15:00

source ~/virtualenv/dask/bin/activate
time srun python dask-mpi.py
