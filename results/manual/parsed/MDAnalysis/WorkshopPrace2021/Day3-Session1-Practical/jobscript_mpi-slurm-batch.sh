#!/bin/bash
#SBATCH --job-name=MPI_job
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=2

source /project/jhlsrf005/JHL_hooks/env
mpirun -np 4 ./mpi_example.py
