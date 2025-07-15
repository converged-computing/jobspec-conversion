#!/bin/bash
#FLUX: --job-name=quirky-staircase-9307
#FLUX: --urgency=16

module load julia/1.7.3
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT
julia top5each.jl $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
