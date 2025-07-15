#!/bin/bash
#FLUX: --job-name=reclusive-fudge-6390
#FLUX: -t=345600
#FLUX: --urgency=16

srun julia fakey.jl $SLURM_ARRAY_TASK_ID 1 1 "linear"
