#!/bin/bash
#FLUX: --job-name=tfim_data
#FLUX: -t=64800
#FLUX: --urgency=16

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
