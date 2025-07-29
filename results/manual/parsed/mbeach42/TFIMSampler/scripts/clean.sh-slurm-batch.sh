#!/bin/bash
#SBATCH --job-name=cleaning
#SBATCH --account=rrg-rgmelko-ab
#SBATCH --output=cleaning.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15GB
#SBATCH --time=12:00:00

export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'
export MKL_NUM_THREADS='1'
export JULIA_NUM_THREADS='1'

module load nixpkgs/16.09 gcc/7.3.0 julia
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1
export JULIA_NUM_THREADS=1
julia --project -O3 --check-bounds=no data_cleaning2.jl
