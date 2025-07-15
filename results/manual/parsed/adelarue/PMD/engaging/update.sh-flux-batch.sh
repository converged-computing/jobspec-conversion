#!/bin/bash
#FLUX: --job-name=strawberry-animal-9504
#FLUX: -t=360
#FLUX: --priority=16

srun julia pkg_updates.jl $SLURM_ARRAY_TASK_ID
