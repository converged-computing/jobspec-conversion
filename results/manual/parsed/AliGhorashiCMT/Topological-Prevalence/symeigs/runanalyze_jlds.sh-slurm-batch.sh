#!/bin/bash
#SBATCH --output=analyzejlds-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH: --exclusive
#SBATCH --array=1,2,6,9,10,11,12,13,14,15,16,17

export sg='$SLURM_ARRAY_TASK_ID'

source /etc/profile
export sg=$SLURM_ARRAY_TASK_ID
julia ./analyze_jlds.jl $sg #For topologies (fragile, trivial, stable)
