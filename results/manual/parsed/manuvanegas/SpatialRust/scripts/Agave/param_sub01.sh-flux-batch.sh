#!/bin/bash
#FLUX: --job-name=wobbly-lettuce-7992
#FLUX: -n=40
#FLUX: --urgency=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ParamScan1.jl
cp /scratch/mvanega1/track01/* ~/SpatialRust/results/track01/
rm /scratch/mvanega1/track01/*
