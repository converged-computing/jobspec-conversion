#!/bin/bash
#FLUX: --job-name=lovable-cupcake-3285
#FLUX: --queue=scavenger
#FLUX: --priority=16

export PATH='/hpc/home/cjp47/julia-1.5.2/bin/:$PATH'

export PATH=/hpc/home/cjp47/julia-1.5.2/bin/:$PATH
julia scripts/snaq_subset1.jl
