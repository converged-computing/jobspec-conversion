#!/bin/bash
#SBATCH --job-name=openmpi
#SBATCH --account=project_2001659
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=2

module load julia/1.8.5
srun julia --project=. test.jl
