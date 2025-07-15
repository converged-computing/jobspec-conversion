#!/bin/bash
#FLUX: --job-name=hairy-cinnamonbun-4806
#FLUX: -t=360
#FLUX: --urgency=16

srun julia pkg_updates.jl $SLURM_ARRAY_TASK_ID
