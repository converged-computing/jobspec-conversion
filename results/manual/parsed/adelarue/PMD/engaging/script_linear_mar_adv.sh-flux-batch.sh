#!/bin/bash
#FLUX: --job-name=adorable-cherry-3797
#FLUX: -t=345600
#FLUX: --priority=16

srun julia fakey.jl $SLURM_ARRAY_TASK_ID 1 1 "linear"
