#!/bin/bash
#FLUX: --job-name=hairy-leg-2066
#FLUX: -n=40
#FLUX: --priority=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ParamScan4.jl
cp /scratch/mvanega1/track04/* ~/SpatialRust/results/track04/
rm /scratch/mvanega1/track04/*
