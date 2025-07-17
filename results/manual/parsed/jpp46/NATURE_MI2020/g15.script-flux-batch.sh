#!/bin/bash
#FLUX: --job-name=15
#FLUX: --queue=teaching
#FLUX: --urgency=16

julia worker.jl ${SLURM_ARRAY_TASK_ID} 15
