#!/bin/bash
#FLUX: --job-name=parallelTest1
#FLUX: -N=8
#FLUX: -t=600
#FLUX: --urgency=16

module load julia
module load intel
srun julia helloParallel.jl
