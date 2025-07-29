#!/bin/bash
#SBATCH --job-name=debug-ABC
#SBATCH --output=logs/ABC/sims/do-%A-%a.o
#SBATCH --error=logs/ABC/sims/do-%A.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:15:00
#SBATCH --array=2

export SLURM_NODEFILE='`scripts/generate_pbs_nodefile.pl`'

module purge
module load julia/1.8.2
export SLURM_NODEFILE=`scripts/generate_pbs_nodefile.pl`
echo `date +%F-%T`
echo $SLURM_JOB_ID
echo $SLURM_JOB_NODELIST
ulimit -s 262144
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ABC/sims/runABC.jl 16 $SLURM_ARRAY_TASK_ID $SLURM_NTASKS 100 #500
