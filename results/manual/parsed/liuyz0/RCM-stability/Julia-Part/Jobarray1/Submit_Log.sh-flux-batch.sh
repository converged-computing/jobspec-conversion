#!/bin/bash
#FLUX: --job-name=stinky-taco-1344
#FLUX: --urgency=16

source /etc/profile
module load julia/1.8.5
julia Simulation_distrv1Log.jl
