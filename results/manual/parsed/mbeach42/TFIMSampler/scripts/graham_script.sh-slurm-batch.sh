#!/bin/bash
#SBATCH --job-name=tfim_data
#SBATCH --account=rrg-rgmelko-ab
#SBATCH --output=tfim_data.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=18:00:00
#SBATCH --array=1-100

export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'
export MKL_NUM_THREADS='1'
export JULIA_NUM_THREADS='1'

module load nixpkgs/16.09 gcc/7.3.0 julia
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1
export JULIA_NUM_THREADS=1
julia --project -O3 --check-bounds=no run_graham.jl $SLURM_ARRAY_TASK_ID
