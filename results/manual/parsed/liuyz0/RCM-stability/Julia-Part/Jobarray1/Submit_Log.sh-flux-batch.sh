#!/bin/bash
#FLUX: --job-name=stinky-destiny-5445
#FLUX: -n=48
#FLUX: --urgency=16

source /etc/profile
module load julia/1.8.5
julia Simulation_distrv1Log.jl
