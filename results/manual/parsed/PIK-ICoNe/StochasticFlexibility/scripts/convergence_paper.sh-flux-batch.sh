#!/bin/bash
#FLUX: --job-name=wobbly-pedo-9901
#FLUX: --queue=largemem
#FLUX: -t=259200
#FLUX: --priority=16

echo "SLURM TASK ID: $SLURM_ARRAY_TASK_ID"
module load julia
julia ./StochasticFlexibility/paper_experiments/conv_simulate.jl run_02_14
