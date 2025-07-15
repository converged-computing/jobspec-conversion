#!/bin/bash
#FLUX: --job-name=bricky-taco-0378
#FLUX: -t=900
#FLUX: --urgency=16

module load sloan/julia/1.0.0
module load sloan/python/modules/2.7
srun julia analysis-complete.jl $SLURM_ARRAY_TASK_ID
