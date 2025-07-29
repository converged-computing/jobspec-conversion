#!/bin/bash
#SBATCH --job-name=openblas_job_40
#SBATCH --account=pc2-mitarbeiter
#SBATCH --output=openblas_job_40.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=00:30:00
#SBATCH --exclusive

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
