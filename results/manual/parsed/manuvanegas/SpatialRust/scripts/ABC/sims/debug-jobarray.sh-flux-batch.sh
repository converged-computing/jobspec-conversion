#!/bin/bash
#FLUX: --job-name=spicy-nalgas-2117
#FLUX: -n=2
#FLUX: --priority=16

export SLURM_NODEFILE='`scripts/generate_pbs_nodefile.pl`'

module purge
module load julia/1.8.2
export SLURM_NODEFILE=`scripts/generate_pbs_nodefile.pl`
echo `date +%F-%T`
echo $SLURM_JOB_ID
echo $SLURM_JOB_NODELIST
ulimit -s 262144
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ABC/sims/runABC.jl 16 $SLURM_ARRAY_TASK_ID $SLURM_NTASKS 100 #500
