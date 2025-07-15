#!/bin/bash
#FLUX: --job-name=persnickety-fork-1704
#FLUX: --exclusive
#FLUX: --urgency=16

export sg='$SLURM_ARRAY_TASK_ID'

source /etc/profile
export sg=$SLURM_ARRAY_TASK_ID
julia ./analyze_jlds.jl $sg #For topologies (fragile, trivial, stable)
