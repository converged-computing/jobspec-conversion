#!/bin/bash
#SBATCH --output=top5norm_collective.log-%j
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1

source /etc/profile
module load julia
module load mpi
mpirun julia top5norm_collective.jl
