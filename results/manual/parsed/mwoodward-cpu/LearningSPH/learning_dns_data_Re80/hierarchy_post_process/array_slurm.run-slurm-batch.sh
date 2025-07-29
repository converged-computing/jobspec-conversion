#!/bin/bash
#FLUX: --job-name=mt08_node
#FLUX: --queue=standard
#FLUX: -t=36000
#FLUX: --urgency=16

echo "$SLURM_ARRAY_TASK_ID"
module load julia/1.6.1
julia ./hpc_code/running_trained_models_long_t_generalization_t50_lf_${SLURM_ARRAY_TASK_ID}.jl 
