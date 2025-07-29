#!/bin/bash
#FLUX: --job-name=E0_TRUE
#FLUX: -t=10800
#FLUX: --urgency=16

module load julia
srun julia OptimizeTrueTrip.jl "anchoring_experiment/E0_TRUE_${SLURM_ARRAY_TASK_ID}_OPT.jld" anchoring_experiment/E0_anchoring_experiment_modeled.jld ${SLURM_ARRAY_TASK_ID}
