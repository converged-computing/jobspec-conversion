#!/bin/bash
#FLUX: --job-name=wobbly-kitty-5243
#FLUX: --exclusive
#FLUX: --priority=16

export sg='$SLURM_ARRAY_TASK_ID'

source /etc/profile
export sg=$SLURM_ARRAY_TASK_ID
julia ./analyze_jlds.jl $sg #For topologies (fragile, trivial, stable)
