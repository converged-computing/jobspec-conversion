#!/bin/bash
#FLUX: --job-name=phat-platanos-1217
#FLUX: --queue=sched_mit_sloan_batch
#FLUX: -t=900
#FLUX: --urgency=16

module load julia/1.2.0
module load sloan/python/modules/2.7
srun julia 2-analysis-complete.jl $SLURM_ARRAY_TASK_ID
