#!/bin/bash
#FLUX: --job-name=cleanup
#FLUX: --queue=wildfire
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load julia/1.5.0
julia ~/SpatialRust/scripts/Agave/ABCcleanup.jl
