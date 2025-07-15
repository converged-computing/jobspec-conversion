#!/bin/bash
#FLUX: --job-name=lovable-chair-9816
#FLUX: --queue=sched_mit_sloan_batch
#FLUX: -t=345600
#FLUX: --priority=16

module load julia
srun julia engaging.jl
