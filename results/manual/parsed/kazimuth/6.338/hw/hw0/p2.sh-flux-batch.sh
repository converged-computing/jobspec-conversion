#!/bin/bash
#FLUX: --job-name=carnivorous-sundae-7711
#FLUX: --priority=16

source /etc/profile
module load julia-1.0
julia p2.jl
