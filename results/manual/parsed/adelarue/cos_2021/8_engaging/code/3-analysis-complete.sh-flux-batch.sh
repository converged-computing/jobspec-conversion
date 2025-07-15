#!/bin/bash
#FLUX: --job-name=expressive-cat-6298
#FLUX: -t=900
#FLUX: --urgency=16

module load julia/1.2.0
module load sloan/python/modules/2.7
srun julia 2-analysis-complete.jl $SLURM_ARRAY_TASK_ID
