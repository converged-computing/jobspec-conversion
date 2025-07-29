#!/bin/bash
#SBATCH --job-name=octavian_job_20
#SBATCH --account=pc2-mitarbeiter
#SBATCH --output=octavian_job_20.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=00:30:00
#SBATCH --exclusive

export JULIA_NUM_THREADS='20 # 20 == single socket'

module reset
export JULIA_NUM_THREADS=20 # 20 == single socket
/scratch/pc2-mitarbeiter/bauerc/.julia/juliaup/julia-1.8.0-rc1+0~x64/bin/julia --project dgemm_octavian.jl 10240
