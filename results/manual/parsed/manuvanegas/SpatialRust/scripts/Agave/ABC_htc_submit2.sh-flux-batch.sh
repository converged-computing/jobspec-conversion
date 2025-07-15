#!/bin/bash
#FLUX: --job-name=milky-blackbean-3457
#FLUX: -n=450
#FLUX: --priority=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/Agave/ABCinit.jl parameters.csv 500000
