#!/bin/bash
#SBATCH --job-name=pi-mpi
#SBATCH --output=output.log
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --exclusive

module load openmpi/3.1.6-gcc-12.2.0-d2gmn55 
mpiexec ~/a.out 1000000000
