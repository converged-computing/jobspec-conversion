#!/usr/bin/env bash
#FLUX --job-name=run-regression
#FLUX --output=regression/{id}.out
#FLUX --time-limit=1400m
#FLUX -N 1
#FLUX -n 1
#FLUX -c 40

module load julia
julia -p 40 regression.jl #$SLURM_ARRAY_TASK_ID