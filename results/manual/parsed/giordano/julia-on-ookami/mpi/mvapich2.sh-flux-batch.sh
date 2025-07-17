#!/bin/bash
#FLUX: --job-name=julia_mvapich2
#FLUX: -N=4
#FLUX: --queue=short
#FLUX: -t=300
#FLUX: --urgency=16

export JULIA_NUM_THREADS='${SLURM_CPUS_PER_TASK:=1}'

module load slurm gcc/11.1.0 mvapich2/gcc11/2.3.6 julia/nightly-5da8d5f17a
export JULIA_NUM_THREADS=${SLURM_CPUS_PER_TASK:=1}
srun julia --project=mvapich2 examples/01-hello.jl
