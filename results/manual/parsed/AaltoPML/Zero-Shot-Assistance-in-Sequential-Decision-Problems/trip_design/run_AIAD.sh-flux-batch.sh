#!/bin/bash
#FLUX: --job-name=E0_AIAD
#FLUX: -t=54000
#FLUX: --priority=16

module load julia
srun julia AIADExperiment.jl "basic_experiment/E0_AIAD_${SLURM_ARRAY_TASK_ID}.jld" basic_experiment/E0_basic_experiment.jld ${SLURM_ARRAY_TASK_ID}
