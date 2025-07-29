#!/bin/bash
#SBATCH --job-name=MPI
#SBATCH --mail-user=tjzhao@ucdavis.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100
#SBATCH --time=00:10:00

module load julia
srun julia reduction.jl
