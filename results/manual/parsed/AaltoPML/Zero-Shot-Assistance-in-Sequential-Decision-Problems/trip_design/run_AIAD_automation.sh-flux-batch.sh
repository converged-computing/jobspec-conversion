#!/bin/bash
#FLUX: --job-name=EL1_AIAD_automate
#FLUX: -t=54000
#FLUX: --priority=16

module load julia
srun julia AIADExperiment.jl "basic_experiment/E0_AIAD_automate_${SLURM_ARRAY_TASK_ID}.jld" basic_experiment/E0_basic_experiment.jld ${SLURM_ARRAY_TASK_ID} AUTOMATE
