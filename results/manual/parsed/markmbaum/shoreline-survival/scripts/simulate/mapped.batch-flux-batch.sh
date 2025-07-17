#!/bin/bash
#FLUX: --job-name=bloated-puppy-9218
#FLUX: -c=48
#FLUX: --queue=huce_cascade
#FLUX: -t=1036800
#FLUX: --urgency=16

module purge
module load Julia/1.7.1-linux-x86_64
julia --threads 48 mapped.jl
