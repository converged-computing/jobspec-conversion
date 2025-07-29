#!/bin/bash
#FLUX: --job-name=trial_job
#FLUX: -n=5
#FLUX: --queue=your_partition_name
#FLUX: -t=7200
#FLUX: --urgency=16

module load julia
SEED=$(head /dev/urandom | tr -dc 0-9 | head -c 10)
julia trial.jl $SLURM_ARRAY_TASK_ID $SEED
