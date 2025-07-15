#!/bin/bash
#FLUX: --job-name=NDQN
#FLUX: --exclusive
#FLUX: --queue=GPUQ
#FLUX: -t=259200
#FLUX: --priority=16

module load Python/3.8.6-GCCcore-10.2.0
julia --optimize=3 --project=. scripts/run_experiment.jl
