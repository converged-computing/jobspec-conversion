#!/bin/bash
#SBATCH --job-name=parallelTest1
#SBATCH --account=hpc_build
#SBATCH --output=parallelTest1_%A.out
#SBATCH --error=parallelTest1_%A.err
#SBATCH --mail-user=teh1m@virginia.edu
#SBATCH --mail-type=end
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=parallel
#SBATCH --constraint=ntasks-per-node=1

module load julia
module load intel
srun julia helloParallel.jl
