#!/bin/bash
#FLUX: --job-name=E0_IM_ORACLE
#FLUX: -t=3600
#FLUX: --priority=16

module load julia
srun julia AutomateOracle.jl "inventory_experiment/E0_ORACLE_${SLURM_ARRAY_TASK_ID}.jld" inventory_experiment/E0_modeled.jld ${SLURM_ARRAY_TASK_ID}
