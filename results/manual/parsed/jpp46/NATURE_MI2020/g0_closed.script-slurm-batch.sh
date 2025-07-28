#!/bin/bash
#FLUX: --job-name=0 closed
#FLUX: --queue=teaching
#FLUX: --urgency=16

julia worker_closed.jl ${SLURM_ARRAY_TASK_ID} 0
