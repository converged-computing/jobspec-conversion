#!/bin/bash
#SBATCH --job-name=mkl_job_20
#SBATCH --account=pc2-mitarbeiter
#SBATCH --output=mkl_job_20.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=00:30:00
#SBATCH --partition=gpu
#SBATCH: --exclusive

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
