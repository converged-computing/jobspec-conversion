#!/bin/bash
#FLUX: --job-name=hello-mango-3280
#FLUX: -n=40
#FLUX: --urgency=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ParamScan5.jl
cp /scratch/mvanega1/track05/* ~/SpatialRust/results/track05/
rm /scratch/mvanega1/track05/*
