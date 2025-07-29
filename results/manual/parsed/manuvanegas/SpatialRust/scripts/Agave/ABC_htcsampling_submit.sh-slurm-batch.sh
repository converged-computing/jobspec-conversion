#!/bin/bash
#FLUX: --job-name=htc_sampling9_0
#FLUX: -n=150
#FLUX: --queue=htc
#FLUX: -t=14400
#FLUX: --urgency=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/Agave/ABCcleanup.jl ABCsampled 1 900000 1000000
