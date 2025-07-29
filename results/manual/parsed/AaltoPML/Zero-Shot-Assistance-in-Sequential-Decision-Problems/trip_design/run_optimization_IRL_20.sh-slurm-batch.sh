#!/bin/bash
#FLUX: --job-name=E0_IRL_OPT_20
#FLUX: -t=12600
#FLUX: --urgency=16

STEP=20
module load julia
srun julia OptimizeTrip.jl "basic_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}_OPT_${STEP}_RESTART.jld" basic_experiment/E0_basic_experiment.jld "basic_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}.jld" ${STEP} RESTART
