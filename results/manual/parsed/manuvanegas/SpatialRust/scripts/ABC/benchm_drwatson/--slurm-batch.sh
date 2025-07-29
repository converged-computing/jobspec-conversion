#!/bin/bash
#SBATCH --job-name=debug-ABC
#SBATCH --output=outs.%x-%A.o
#SBATCH --error=outs.%x-%A.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00
#SBATCH --array=1-2

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.7.2
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ABCsims/compBase.jl parameters.csv $SLURM_ARRAY_TASK_ID $SLURM_NTASKS
