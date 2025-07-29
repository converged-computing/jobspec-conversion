#!/bin/bash
#SBATCH --job-name=redistricting
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=1-00:00:00

module load julia/1.6.1
julia mggg.jl
