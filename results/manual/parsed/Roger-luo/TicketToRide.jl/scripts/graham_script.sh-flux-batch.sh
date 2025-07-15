#!/bin/bash
#FLUX: --job-name=minimal_VQE_cirq
#FLUX: -t=10800
#FLUX: --urgency=16

module load nixpkgs/16.09 gcc/7.3.0 julia
julia --project -O3 --check-bounds=no run_graham.jl $SLURM_ARRAY_TASK_ID
