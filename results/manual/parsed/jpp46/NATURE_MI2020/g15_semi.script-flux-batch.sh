#!/bin/bash
#FLUX: --job-name=15 semi
#FLUX: --queue=teaching
#FLUX: --urgency=16

julia worker_semi.jl ${SLURM_ARRAY_TASK_ID} 15
