#!/bin/bash
#FLUX: --job-name=faux-leg-6471
#FLUX: --exclusive
#FLUX: --urgency=16

export JULIA_NUM_THREADS='$NTHREADS'
export OMP_NUM_THREADS='$NTHREADS'
export OMP_PLACES='CORES'
export OMP_PROC_BIND='CLOSE'

module reset
NTHREADS=40 # 40 == full node
export JULIA_NUM_THREADS=$NTHREADS
export OMP_NUM_THREADS=$NTHREADS
export OMP_PLACES=CORES
export OMP_PROC_BIND=CLOSE
/scratch/pc2-mitarbeiter/bauerc/.julia/juliaup/julia-1.8.0-rc1+0~x64/bin/julia --project dgemm_openblas.jl 10240
