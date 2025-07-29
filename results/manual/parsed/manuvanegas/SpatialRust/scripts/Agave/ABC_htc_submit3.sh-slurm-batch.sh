#!/bin/bash
#FLUX: --job-name=ABCquart
#FLUX: -n=450
#FLUX: -t=14400
#FLUX: --urgency=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/Agave/ABCinit.jl parameters.csv 250000 500000
