#!/bin/bash
#FLUX: --job-name=openmpi_threads
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --queue=test
#FLUX: -t=900
#FLUX: --priority=16

export JULIA_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load julia/1.8.5
export JULIA_NUM_THREADS="$SLURM_CPUS_PER_TASK"
srun julia --project=. test.jl
