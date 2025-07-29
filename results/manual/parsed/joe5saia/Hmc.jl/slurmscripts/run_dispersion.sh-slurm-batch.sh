#!/bin/bash
#SBATCH --job-name=dispersion
#SBATCH --account=sscc
#SBATCH --output=output/slurm/slurm_dispersion.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=02:00:00
#SBATCH --chdir=/moto/sscc/projects/biasedexpectations

module load julia
julia --project=. code/dispersion.jl
