#!/bin/bash
#FLUX: --job-name=sims
#FLUX: --queue=short
#FLUX: --urgency=16

export JULIA_DEPOT_PATH='/workspace/ane/.julia'

export JULIA_DEPOT_PATH="/workspace/ane/.julia"
echo "slurm task ID = $SLURM_ARRAY_TASK_ID"
nreps=20
/workspace/software/julia-1.5.1/bin/julia /workspace/ane/st679simulations/onesimulation.jl $SLURM_ARRAY_TASK_ID $nreps
