#!/bin/bash
#FLUX: --job-name=mkl_job_20
#FLUX: -c=40
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export JULIA_NUM_THREADS='$NTHREADS'
export MKL_NUM_THREADS='$NTHREADS'
export MKL_DYNAMIC='false'
export OMP_PLACES='CORES'
export OMP_PROC_BIND='CLOSE'

module reset
NTHREADS=20 # 20 == single socket
export JULIA_NUM_THREADS=$NTHREADS
export MKL_NUM_THREADS=$NTHREADS
export MKL_DYNAMIC=false
export OMP_PLACES=CORES
export OMP_PROC_BIND=CLOSE
/scratch/pc2-mitarbeiter/bauerc/.julia/juliaup/julia-1.8.0-rc1+0~x64/bin/julia --project dgemm_mkl.jl 10240
