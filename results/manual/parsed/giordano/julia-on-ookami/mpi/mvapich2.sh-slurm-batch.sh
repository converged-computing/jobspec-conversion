#!/bin/bash
#SBATCH --job-name=julia_mvapich2
#SBATCH --output=julia_mvapich2.log
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=1

export JULIA_NUM_THREADS='${SLURM_CPUS_PER_TASK:=1}'

module load slurm gcc/11.1.0 mvapich2/gcc11/2.3.6 julia/nightly-5da8d5f17a
export JULIA_NUM_THREADS=${SLURM_CPUS_PER_TASK:=1}
srun julia --project=mvapich2 examples/01-hello.jl
