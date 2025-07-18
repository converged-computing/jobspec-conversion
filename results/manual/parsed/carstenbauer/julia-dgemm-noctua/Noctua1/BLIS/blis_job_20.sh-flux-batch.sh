#!/bin/bash
#FLUX: --job-name=blis_job_20
#FLUX: -c=40
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export JULIA_NUM_THREADS='$NTHREADS'
export BLIS_NUM_THREADS='$NTHREADS'
export OMP_PLACES='CORES # does BLIS respect OMP variables?'
export OMP_PROC_BIND='CLOSE # does BLIS respect OMP variables?'

module reset
NTHREADS=20 # 20 == single socket
export JULIA_NUM_THREADS=$NTHREADS
export BLIS_NUM_THREADS=$NTHREADS
export OMP_PLACES=CORES # does BLIS respect OMP variables?
export OMP_PROC_BIND=CLOSE # does BLIS respect OMP variables?
/scratch/pc2-mitarbeiter/bauerc/.julia/juliaup/julia-1.8.0-rc1+0~x64/bin/julia --project dgemm_blis.jl 10240
