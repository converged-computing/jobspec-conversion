#!/bin/bash
#SBATCH --job-name=daxpy_cpu
#SBATCH --account=pc2-mitarbeiter
#SBATCH --output=daxpy_cpu_job-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --exclusive

export JULIA_DEPOT_PATH=':/scratch/hpc-lco-usrtr/.julia_ucl'

ml r
ml lang/JuliaHPC/1.10.0-foss-2022a-CUDA-11.7.0 
export JULIA_DEPOT_PATH=:/scratch/hpc-lco-usrtr/.julia_ucl
julia --project -t 8 daxpy_cpu.jl
