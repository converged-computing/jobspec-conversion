#!/bin/bash
#FLUX: --job-name=lin_nmar_out
#FLUX: --queue=sched_mit_sloan_batch
#FLUX: -t=345600
#FLUX: --urgency=16

srun julia fakey.jl $SLURM_ARRAY_TASK_ID 1 1 "linear"
