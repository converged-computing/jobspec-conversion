#!/bin/bash
#SBATCH --output=log/snaq.out
#SBATCH --error=log/snaq.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=2G
#SBATCH --partition=scavenger

export PATH='/hpc/home/cjp47/julia-1.5.2/bin/:$PATH'

export PATH=/hpc/home/cjp47/julia-1.5.2/bin/:$PATH
julia scripts/snaq_subset1.jl
