#!/bin/bash
#SBATCH --job-name=htc_sampling9_0
#SBATCH --output=%x-%j.o
#SBATCH --error=%x-%j.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=150
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --nodelist=cg40-[1-6]

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/Agave/ABCcleanup.jl ABCsampled 1 900000 1000000
