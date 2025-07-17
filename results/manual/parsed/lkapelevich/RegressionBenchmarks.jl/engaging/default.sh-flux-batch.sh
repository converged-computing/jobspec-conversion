#!/bin/bash
#FLUX: --job-name=cowy-poo-6757
#FLUX: --queue=sched_mit_sloan_batch
#FLUX: -t=345600
#FLUX: --urgency=16

module load julia
srun julia engaging.jl
