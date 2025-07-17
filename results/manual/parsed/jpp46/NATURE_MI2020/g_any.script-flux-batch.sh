#!/bin/bash
#FLUX: --job-name=any 5
#FLUX: --queue=teaching
#FLUX: --urgency=16

cd \$HOME/NATURE_MI2020/
julia worker.jl ${SLURM_ARRAY_TASK_ID} 5
