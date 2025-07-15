#!/bin/bash
#FLUX: --job-name=loopy-lamp-8840
#FLUX: -n=2
#FLUX: --urgency=16

export SLURM_NODEFILE='`scripts/generate_pbs_nodefile.pl`'

module purge
module load julia/1.8.2
echo `date +%F-%T`
echo $SLURM_JOB_ID
echo $SLURM_JOB_NODELIST
export SLURM_NODEFILE=`scripts/generate_pbs_nodefile.pl`
julia --machine-file $SLURM_NODEFILE \
~/SpatialRust/scripts/ABC/dists/calcDistsnoVar.jl 16
