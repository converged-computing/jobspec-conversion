#!/bin/bash
#SBATCH --output=p2.log-%j
#SBATCH --nodes=10
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1

source /etc/profile
module load julia-1.0
julia p2.jl
