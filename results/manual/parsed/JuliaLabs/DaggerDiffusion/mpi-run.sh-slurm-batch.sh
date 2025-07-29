#!/bin/bash
#SBATCH --job-name=mpi-diffusion
#SBATCH --output=output.log
#SBATCH --mail-user=jpsamaroo@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=5

export UCX_ERROR_SIGNALS='SIGILL,SIGBUS,SIGFPE'

export UCX_ERROR_SIGNALS="SIGILL,SIGBUS,SIGFPE"
module list
srun --mpi=pmi2 julia --project main.jl
