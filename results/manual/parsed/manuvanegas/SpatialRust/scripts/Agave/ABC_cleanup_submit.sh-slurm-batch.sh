#!/bin/bash
#SBATCH --job-name=cleanup
#SBATCH --output=%x-%j.o
#SBATCH --error=%x-%j.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00

module purge
module load julia/1.5.0
julia ~/SpatialRust/scripts/Agave/ABCcleanup.jl
