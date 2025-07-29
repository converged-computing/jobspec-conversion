#!/bin/bash
#FLUX --job-name=ornery-parsnip-6118
#FLUX --queue=sched_any_quicktest
#FLUX -t=10
#FLUX --urgency=16

module load julia/1.7.3
julia shortestpath_many.jl $SLURM_ARRAY_TASK_ID
