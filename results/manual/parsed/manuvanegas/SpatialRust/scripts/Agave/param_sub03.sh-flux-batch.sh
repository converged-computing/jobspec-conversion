#!/bin/bash
#FLUX: --job-name=conspicuous-nalgas-8377
#FLUX: -n=40
#FLUX: --urgency=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ParamScan3.jl
cp /scratch/mvanega1/track03/* ~/SpatialRust/results/track03/
rm /scratch/mvanega1/track03/*
