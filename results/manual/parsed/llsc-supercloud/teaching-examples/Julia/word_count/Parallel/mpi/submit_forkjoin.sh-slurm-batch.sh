#!/bin/bash
#SBATCH --output=top5norm_forkjoin.log-%j
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1

module load julia/1.7.3
module load mpi/openmpi-4.1.3
mpirun julia top5norm_forkjoin.jl
