#!/bin/bash
#SBATCH --output=pi-mpi4py.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:10:00

module purge
module load anaconda
mpirun python pi-mpi.py
