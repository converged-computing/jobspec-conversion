#!/bin/bash
#FLUX: --job-name=cowy-milkshake-3109
#FLUX: --urgency=16

source /etc/profile
module load julia-1.0
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT
julia top5each.jl $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
