#!/bin/bash
#FLUX: --job-name=roll hill
#FLUX: --queue=teaching
#FLUX: --urgency=16

cd \$HOME/NATURE_MI2020/
julia worker_roll_hill.jl ${SLURM_ARRAY_TASK_ID}
