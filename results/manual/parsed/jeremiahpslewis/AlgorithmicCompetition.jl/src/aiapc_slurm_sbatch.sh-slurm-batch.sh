#!/bin/bash
#SBATCH --job-name=array_job
#SBATCH --output=log/array_job_%A_%a.out
#SBATCH --error=log/array_job_%A_%a.err
#SBATCH --mail-user=irddcc1@mail.uni-paderborn.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1500M
#SBATCH --time=15:00:00
#SBATCH --array=1-1000

export N_ITERATIONS='1 '
export DEBUG='1'
export VERSION='2024-05-22-debug'

export N_ITERATIONS=1 
export DEBUG=1
export VERSION="2024-05-22-debug"
julia --project=. src/aiapc_slurm_batch.jl
