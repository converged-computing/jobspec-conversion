#!/bin/bash
#FLUX: --job-name=hairy-hobbit-0931
#FLUX: -n=28
#FLUX: --priority=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/Agave/ABCcleanup.jl
