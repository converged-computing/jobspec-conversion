#!/bin/bash
#FLUX --job-name=fuzzy-kitty-5461
#FLUX -N=10
#FLUX -n=10
#FLUX --urgency=16

source /etc/profile
module load julia-1.0
julia p2.jl
