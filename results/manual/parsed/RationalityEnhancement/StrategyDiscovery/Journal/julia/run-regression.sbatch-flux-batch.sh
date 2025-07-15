#!/bin/bash
#FLUX: --job-name=run-regression
#FLUX: -c=40
#FLUX: -t=84000
#FLUX: --priority=16

module load julia
julia -p 40 regression.jl #$SLURM_ARRAY_TASK_ID
