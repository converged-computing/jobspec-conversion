#!/bin/bash
#FLUX: --job-name=exp2
#FLUX: -t=86400
#FLUX: --urgency=16

echo Hello
sleep 10
echo Starting
module load Julia
stdbuf -o0 -e0 julia  --color=no -O3 cape_explanations.jl  --task $1  #-i $SLURM_ARRAY_TASK_ID
