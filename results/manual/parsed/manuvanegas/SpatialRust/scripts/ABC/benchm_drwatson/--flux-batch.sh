#!/bin/bash
#FLUX: --job-name=arid-dog-9814
#FLUX: -n=5
#FLUX: --urgency=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.7.2
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ABCsims/compBase.jl parameters.csv $SLURM_ARRAY_TASK_ID $SLURM_NTASKS
