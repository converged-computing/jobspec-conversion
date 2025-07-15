#!/bin/bash
#FLUX: --job-name=creamy-taco-8483
#FLUX: --urgency=16

source /etc/profile
module load julia-1.0
julia p2.jl
