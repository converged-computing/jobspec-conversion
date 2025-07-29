#!/bin/bash
#SBATCH --job-name=mpi_ec
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

module load gahpc
srun julia -p auto -L ./src/gahpc.jl
