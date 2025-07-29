#!/bin/bash
#SBATCH --job-name=pi-mpi
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:05:00
#SBATCH --partition=production
#SBATCH --constraint=skylake

module load GCC OpenMPI Python numpy mpi4py
echo "Starting calculation at $(date)"
srun python pi-mpi.py
echo "Completed calculation at $(date)"
