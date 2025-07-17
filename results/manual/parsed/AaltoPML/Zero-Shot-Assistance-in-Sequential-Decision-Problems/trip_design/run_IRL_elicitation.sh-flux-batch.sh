#!/bin/bash
#FLUX: --job-name=E0_IRL
#FLUX: -t=28800
#FLUX: --urgency=16

module load julia
srun julia ElicitationExperiment.jl IRL "basic_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}.jld" basic_experiment/E0_basic_experiment.jld ${SLURM_ARRAY_TASK_ID}
