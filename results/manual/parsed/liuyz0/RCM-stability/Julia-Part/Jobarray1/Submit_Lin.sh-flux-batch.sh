#!/bin/bash
#FLUX: --job-name=muffled-avocado-0938
#FLUX: -n=48
#FLUX: --urgency=16

source /etc/profile
module load julia/1.8.5
julia Simulation_distrv1Lin.jl
