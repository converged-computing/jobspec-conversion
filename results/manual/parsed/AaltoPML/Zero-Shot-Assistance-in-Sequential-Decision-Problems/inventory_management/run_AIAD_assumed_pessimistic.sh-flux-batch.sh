#!/bin/bash
#FLUX: --job-name=E0_IM_AIAD_pess
#FLUX: -t=21600
#FLUX: --urgency=16

module load julia
srun julia AIADExperiment.jl "inventory_experiment/E0_AIAD_assumed_pessimistic_${SLURM_ARRAY_TASK_ID}.jld" inventory_experiment/E0_not_modeled_assumed_pessimistic.jld ${SLURM_ARRAY_TASK_ID}
