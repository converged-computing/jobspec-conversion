#!/bin/bash
#FLUX: --job-name=study1
#FLUX: -n=30
#FLUX: -t=28800
#FLUX: --priority=16

module load StdEnv/2023 openmpi julia/1.9.3
srun julia --project=../. ../src/study1.jl
