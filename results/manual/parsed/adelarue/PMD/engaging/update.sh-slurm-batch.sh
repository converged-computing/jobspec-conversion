#!/bin/bash
#FLUX: --job-name=pkg
#FLUX: --queue=sched_mit_sloan_batch
#FLUX: -t=360
#FLUX: --urgency=16

srun julia pkg_updates.jl $SLURM_ARRAY_TASK_ID
