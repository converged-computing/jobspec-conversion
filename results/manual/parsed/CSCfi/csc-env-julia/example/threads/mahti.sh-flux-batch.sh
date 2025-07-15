#!/bin/bash
#FLUX: --job-name=threads
#FLUX: -c=128
#FLUX: --queue=test
#FLUX: -t=900
#FLUX: --urgency=16

export JULIA_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load julia/1.8.5
export JULIA_NUM_THREADS="$SLURM_CPUS_PER_TASK"
srun julia --project=. benchmark.jl -n 1000000000
