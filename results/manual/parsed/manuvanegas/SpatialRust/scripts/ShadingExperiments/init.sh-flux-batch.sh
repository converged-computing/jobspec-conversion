#!/bin/bash
#FLUX: --job-name=blank-diablo-4076
#FLUX: -n=30
#FLUX: --priority=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.7.2
export SLURM_NODEFILE=`generate_pbs_nodefile`
time julia --machine-file $SLURM_NODEFILE \
~/SpatialRust/scripts/ShadingExperiments/InitTimes.jl $SLURM_NTASKS
