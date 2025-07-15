#!/bin/bash
#FLUX: --job-name=cuda
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --priority=16

module load julia/1.8.5
srun julia --project=. test.jl
