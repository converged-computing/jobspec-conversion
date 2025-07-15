#!/bin/bash
#FLUX: --job-name=E0_IRL_IM_OPT_30
#FLUX: -t=9000
#FLUX: --priority=16

STEP=30
module load julia
srun julia Automate.jl "inventory_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}_OPT_${STEP}.jld" inventory_experiment/E0_modeled.jld "inventory_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}.jld" ${STEP}
