#!/bin/bash
#FLUX: --job-name=E0_IM_AIAD
#FLUX: -t=18000
#FLUX: --priority=16

module load julia
srun julia AIADExperiment.jl "inventory_experiment/E0_AIAD_${SLURM_ARRAY_TASK_ID}.jld" inventory_experiment/E0_modeled.jld ${SLURM_ARRAY_TASK_ID}
