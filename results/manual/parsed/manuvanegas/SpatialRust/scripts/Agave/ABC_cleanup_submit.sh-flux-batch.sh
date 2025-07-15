#!/bin/bash
#FLUX: --job-name=stanky-omelette-2023
#FLUX: --priority=16

module purge
module load julia/1.5.0
julia ~/SpatialRust/scripts/Agave/ABCcleanup.jl
