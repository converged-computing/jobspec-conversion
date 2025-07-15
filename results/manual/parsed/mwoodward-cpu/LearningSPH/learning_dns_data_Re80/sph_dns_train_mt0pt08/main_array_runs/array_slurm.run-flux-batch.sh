#!/bin/bash
#FLUX: --job-name=mt08_re80
#FLUX: --queue=standard
#FLUX: -t=864000
#FLUX: --urgency=16

echo "$SLURM_ARRAY_TASK_ID"
module load julia/1.6.1
julia ./main4_${SLURM_ARRAY_TASK_ID}.jl lf forward 0 unif_tracers 20 2200 1
