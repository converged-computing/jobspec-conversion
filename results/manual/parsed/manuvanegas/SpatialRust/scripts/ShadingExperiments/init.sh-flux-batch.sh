#!/bin/bash
#FLUX: --job-name=expressive-milkshake-8768
#FLUX: -n=30
#FLUX: --urgency=16

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.7.2
export SLURM_NODEFILE=`generate_pbs_nodefile`
time julia --machine-file $SLURM_NODEFILE \
~/SpatialRust/scripts/ShadingExperiments/InitTimes.jl $SLURM_NTASKS
