#!/bin/bash
#FLUX: --job-name=E0_IRL_OPT_5
#FLUX: -t=10800
#FLUX: --priority=16

STEP=5
module load julia
srun julia OptimizeTrip.jl "anchoring_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}_OPT_${STEP}_RESTART.jld" anchoring_experiment/E0_anchoring_experiment_modeled.jld "anchoring_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}.jld" ${STEP} RESTART
