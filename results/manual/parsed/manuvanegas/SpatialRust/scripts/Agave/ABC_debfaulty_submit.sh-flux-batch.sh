#!/bin/bash
#FLUX: --job-name=debp_sampling
#FLUX: -n=28
#FLUX: --queue=wildfire
#FLUX: -t=900
#FLUX: --urgency=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/Agave/ABCcleanup.jl
