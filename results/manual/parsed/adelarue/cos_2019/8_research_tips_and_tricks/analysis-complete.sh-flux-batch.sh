#!/bin/bash
#FLUX: --job-name=crusty-dog-0802
#FLUX: --queue=sched_mit_sloan_batch
#FLUX: -t=900
#FLUX: --urgency=16

module load sloan/julia/1.0.0
module load sloan/python/modules/2.7
srun julia analysis-complete.jl $SLURM_ARRAY_TASK_ID
