#!/bin/bash
#SBATCH --job-name=bosonstar
#SBATCH --output=logs/out.%j
#SBATCH --error=logs/err.%j
#SBATCH --mail-user=<user-email>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=64
#SBATCH --chdir=./

export JULIA_NUM_THREADS='64'
export SLURM_HINT='multithread '

export JULIA_NUM_THREADS=64
export SLURM_HINT=multithread 
julia --project=BosonStars main.jl
