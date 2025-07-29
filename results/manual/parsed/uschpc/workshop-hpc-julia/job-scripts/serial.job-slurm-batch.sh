#!/bin/bash
#SBATCH --account=<project_id>
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=01:00:00

module purge
module load julia/1.10.2
julia script.jl
