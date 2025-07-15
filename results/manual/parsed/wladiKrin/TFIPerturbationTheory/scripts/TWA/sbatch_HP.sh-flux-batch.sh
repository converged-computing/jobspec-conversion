#!/bin/bash
#FLUX: --job-name=TWA_HP
#FLUX: -c=48
#FLUX: --urgency=16

srun julia -t 48 TWA_HP.jl ${SLURM_ARRAY_TASK_ID}
