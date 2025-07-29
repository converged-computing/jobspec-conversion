#!/bin/bash
#SBATCH --job-name=run-regression
#SBATCH --output=regression/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=23:20:00

module load julia
julia -p 40 regression.jl #$SLURM_ARRAY_TASK_ID
