#!/bin/bash
#FLUX: --job-name=CVs
#FLUX: -n=5
#FLUX: --queue=public
#FLUX: -t=3600
#FLUX: --urgency=16

export SLURM_NODEFILE='`scripts/generate_pbs_nodefile.pl`'

module purge
module load julia/1.8.2
echo `date +%F-%T`
echo $SLURM_JOB_ID
echo $SLURM_JOB_NODELIST
export SLURM_NODEFILE=`scripts/generate_pbs_nodefile.pl`
julia --machine-file $SLURM_NODEFILE \
~/SpatialRust/scripts/ShadingExperiments/calcRepCVs.jl 600 22.0 0.8 0.7 4
