#!/bin/bash
#FLUX: --job-name=reclusive-peas-5210
#FLUX: --urgency=16

module purge
module load julia/1.5.0
julia ~/SpatialRust/scripts/Agave/ABCcleanup.jl
