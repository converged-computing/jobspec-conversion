#!/bin/bash
#FLUX: --job-name=muffled-mango-5267
#FLUX: --priority=16

module reset
module load system singularity
singularity exec singularity_container.sif bash -c "./run_in_container.sh $SLURM_ARRAY_TASK_ID"
