#!/bin/bash
#FLUX: --job-name=arid-malarkey-9074
#FLUX: -n=150
#FLUX: --priority=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/Agave/ABCcleanup.jl ABCsampled 1 900000 1000000
