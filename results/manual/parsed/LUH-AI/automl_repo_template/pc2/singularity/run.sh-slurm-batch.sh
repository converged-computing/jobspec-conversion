#!/bin/bash
#FLUX: --job-name=<JOBNAME>
#FLUX: -n=4
#FLUX: --queue=normal
#FLUX: -t=300
#FLUX: --urgency=16

module reset
module load system singularity
singularity exec singularity_container.sif bash -c "./run_in_container.sh $SLURM_ARRAY_TASK_ID"
