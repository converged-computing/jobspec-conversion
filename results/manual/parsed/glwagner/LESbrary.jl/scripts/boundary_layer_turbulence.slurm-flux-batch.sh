#!/bin/bash
#FLUX: --job-name=boopy-underoos-1336
#FLUX: -n=4
#FLUX: -t=86400
#FLUX: --urgency=16

module load openmpi/3.1.4 cuda/10.0
cd $HOME/LESbrary/
julia --project simulation/boundary_layer_turbulence_simple.jl
