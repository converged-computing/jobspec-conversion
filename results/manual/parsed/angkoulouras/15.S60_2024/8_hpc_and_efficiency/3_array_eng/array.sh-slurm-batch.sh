#!/bin/bash
#SBATCH --output=run_%a.out
#SBATCH --error=run_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:00:10
#SBATCH --array=1-3

module load julia/1.7.3
julia shortestpath_many.jl $SLURM_ARRAY_TASK_ID
