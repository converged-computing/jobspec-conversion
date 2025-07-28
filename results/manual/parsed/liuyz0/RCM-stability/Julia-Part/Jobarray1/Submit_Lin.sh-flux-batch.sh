#!/bin/bash
#FLUX: --job-name=spicy-staircase-4531
#FLUX: -n=48
#FLUX: --urgency=16

source /etc/profile
module load julia/1.8.5
julia Simulation_distrv1Lin.jl
