#!/bin/bash
#SBATCH --job-name=mpi-circle
#SBATCH --output=SlurmOut/mpi-%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=west

mpirun -np 5 ./circle 13
