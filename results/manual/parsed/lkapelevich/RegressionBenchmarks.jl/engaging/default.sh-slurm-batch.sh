#!/bin/bash
#FLUX: --job-name=red-motorcycle-3215
#FLUX: --queue=sched_mit_sloan_batch
#FLUX: -t=345600
#FLUX: --urgency=16

module load julia
srun julia engaging.jl
