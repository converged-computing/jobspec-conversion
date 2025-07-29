#!/bin/bash
#FLUX: --job-name=shadeexp
#FLUX: -n=30
#FLUX: -t=7200
#FLUX: --urgency=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.7.2
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE \
~/SpatialRust/scripts/ShadingExperiments/RunExperiment.jl 300 23.5 0.65 true
