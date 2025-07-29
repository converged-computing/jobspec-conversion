#!/bin/bash
#SBATCH --job-name=spatialR
#SBATCH --output=%x-%j.o
#SBATCH --error=%x-%j.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --time=03:59:59

export SLURM_NODEFILE='`generate_pbs_nodefile`'

module purge
module load julia/1.5.0
export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --machine-file $SLURM_NODEFILE ~/SpatialRust/scripts/ParamScan1.jl
cp /scratch/mvanega1/track01/* ~/SpatialRust/results/track01/
rm /scratch/mvanega1/track01/*
