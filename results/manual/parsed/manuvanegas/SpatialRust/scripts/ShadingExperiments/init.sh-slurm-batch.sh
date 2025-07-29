#!/bin/bash
#SBATCH --job-name=shadeexp
#SBATCH --output=logs/shading/o-%A.o
#SBATCH --error=logs/shading/o-%A.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=30
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.7.2
export SLURM_NODEFILE=`generate_pbs_nodefile`
time julia --machine-file $SLURM_NODEFILE \
~/SpatialRust/scripts/ShadingExperiments/InitTimes.jl $SLURM_NTASKS
