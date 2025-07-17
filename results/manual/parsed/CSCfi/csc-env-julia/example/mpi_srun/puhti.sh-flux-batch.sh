#!/bin/bash
#FLUX: --job-name=openmpi
#FLUX: -N=2
#FLUX: --queue=test
#FLUX: -t=900
#FLUX: --urgency=16

module load julia/1.8.5
srun julia --project=. test.jl
