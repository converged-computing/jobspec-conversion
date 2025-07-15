#!/bin/bash
#FLUX: --job-name=quirky-parrot-4361
#FLUX: -n=5
#FLUX: --urgency=16

export SLURM_NODEFILE='`scripts/generate_pbs_nodefile.pl`'

module purge
module load julia/1.8.2
export SLURM_NODEFILE=`scripts/generate_pbs_nodefile.pl`
echo `date +%F-%T`
echo $SLURM_JOB_ID
echo $SLURM_JOB_NODELIST
julia --machine-file $SLURM_NODEFILE \
~/SpatialRust/scripts/ShadingExperiments/runExperiment.jl 50 22.0 0.8 0.7 $SLURM_ARRAY_TASK_ID 5
