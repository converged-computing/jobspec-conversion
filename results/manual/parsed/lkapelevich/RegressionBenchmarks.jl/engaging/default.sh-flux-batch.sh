#!/bin/bash
#FLUX --job-name=dinosaur-soup-6784
#FLUX --queue=sched_mit_sloan_batch
#FLUX -t=345600
#FLUX --urgency=16

module load julia
srun julia engaging.jl
