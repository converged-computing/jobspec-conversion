#!/bin/bash
#FLUX: --job-name=MPI
#FLUX: -n=3
#FLUX: --queue=high
#FLUX: -t=600
#FLUX: --urgency=16

module load julia
srun julia reduction.jl
