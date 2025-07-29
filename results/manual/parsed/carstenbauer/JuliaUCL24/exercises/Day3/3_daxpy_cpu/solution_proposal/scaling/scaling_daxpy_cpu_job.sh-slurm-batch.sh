#!/bin/bash
#SBATCH --job-name=scaling_daxpy_cpu
#SBATCH --account=pc2-mitarbeiter
#SBATCH --output=scaling_daxpy_cpu_job-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --exclusive

export JULIA_DEPOT_PATH=':/scratch/hpc-lco-usrtr/.julia_ucl'

ml r
ml lang/JuliaHPC/1.10.0-foss-2022a-CUDA-11.7.0 
export JULIA_DEPOT_PATH=:/scratch/hpc-lco-usrtr/.julia_ucl
julia --project -t 128 scaling_daxpy_cpu.jl
