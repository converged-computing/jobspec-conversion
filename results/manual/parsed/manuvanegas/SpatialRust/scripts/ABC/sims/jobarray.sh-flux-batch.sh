#!/bin/bash
#FLUX: --job-name=wobbly-sundae-4851
#FLUX: -n=5
#FLUX: --priority=16

export SLURM_NODEFILE='`scripts/generate_pbs_nodefile.pl`'

module purge
module load julia/1.8.2
ulimit -s 262144
echo `date +%F-%T`
echo $SLURM_JOB_ID
echo $SLURM_JOB_NODELIST
export SLURM_NODEFILE=`scripts/generate_pbs_nodefile.pl`
cp $SLURM_NODEFILE logs/ABC/nodefiles/nodes_${SLURM_ARRAY_TASK_ID}
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ABC/sims/runABC.jl \
16 $SLURM_ARRAY_TASK_ID $SLURM_NTASKS 4000 #2500 # 250 #500
