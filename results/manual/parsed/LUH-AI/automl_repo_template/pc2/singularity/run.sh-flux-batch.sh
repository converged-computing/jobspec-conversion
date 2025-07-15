#!/bin/bash
#FLUX: --job-name=hanky-lettuce-6426
#FLUX: --urgency=16

module reset
module load system singularity
singularity exec singularity_container.sif bash -c "./run_in_container.sh $SLURM_ARRAY_TASK_ID"
