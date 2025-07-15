#!/bin/bash
#FLUX: --job-name=blank-noodle-4442
#FLUX: -n=5
#FLUX: --urgency=16

export SLURM_NODEFILE='`scripts/generate_pbs_nodefile.pl`'

module purge
module load julia/1.8.2
export SLURM_NODEFILE=`scripts/generate_pbs_nodefile.pl`
cp $SLURM_NODEFILE logs/ABC/nodefiles/nodes_${SLURM_ARRAY_TASK_ID}
julia --machine-file $SLURM_NODEFILE --sysimage src/PkgCompile/ABCPrecompiledSysimage.so ~/SpatialRust/scripts/ABC/sims/re-runABC.jl 5 $SLURM_ARRAY_TASK_ID $SLURM_NTASKS 2000 quants3 14
