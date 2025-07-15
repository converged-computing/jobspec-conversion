#!/bin/bash
#FLUX: --job-name="0"
#FLUX: --queue=teaching
#FLUX: --priority=16

julia worker.jl ${SLURM_ARRAY_TASK_ID} 0
