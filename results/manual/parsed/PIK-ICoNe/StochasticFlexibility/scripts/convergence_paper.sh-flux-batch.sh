#!/bin/bash
#FLUX: --job-name=crunchy-squidward-7762
#FLUX: --queue=largemem
#FLUX: -t=259200
#FLUX: --urgency=16

echo "SLURM TASK ID: $SLURM_ARRAY_TASK_ID"
module load julia
julia ./StochasticFlexibility/paper_experiments/conv_simulate.jl run_02_14
