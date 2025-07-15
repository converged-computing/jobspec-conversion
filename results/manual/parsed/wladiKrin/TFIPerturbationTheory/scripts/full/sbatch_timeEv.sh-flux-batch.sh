#!/bin/bash
#FLUX: --job-name=EDTimeEvol
#FLUX: -c=48
#FLUX: --priority=16

julia -t 48 HfullBound_timeEvol.jl ${SLURM_ARRAY_TASK_ID}
