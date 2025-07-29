#!/bin/bash
#FLUX: --job-name=dispersion
#FLUX: -t=7200
#FLUX: --urgency=16

module load julia
julia --project=. code/dispersion.jl
