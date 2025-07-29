#!/bin/bash
#SBATCH --job-name=reABC
#SBATCH --output=logs/ABC/sims/ro-%A-%a.o
#SBATCH --error=logs/ABC/sims/ro-%A.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --time=03:30:00
#SBATCH --array=1-100

export SLURM_NODEFILE='`scripts/generate_pbs_nodefile.pl`'

module purge
module load julia/1.8.2
export SLURM_NODEFILE=`scripts/generate_pbs_nodefile.pl`
cp $SLURM_NODEFILE logs/ABC/nodefiles/nodes_${SLURM_ARRAY_TASK_ID}
julia --machine-file $SLURM_NODEFILE --sysimage src/PkgCompile/ABCPrecompiledSysimage.so ~/SpatialRust/scripts/ABC/sims/re-runABC.jl 5 $SLURM_ARRAY_TASK_ID $SLURM_NTASKS 2000 quants3 14
