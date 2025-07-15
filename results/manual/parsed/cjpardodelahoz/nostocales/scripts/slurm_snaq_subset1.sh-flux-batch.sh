#!/bin/bash
#FLUX: --job-name=strawberry-lemur-1988
#FLUX: --queue=scavenger
#FLUX: --urgency=16

export PATH='/hpc/home/cjp47/julia-1.5.2/bin/:$PATH'

export PATH=/hpc/home/cjp47/julia-1.5.2/bin/:$PATH
julia scripts/snaq_subset1.jl
