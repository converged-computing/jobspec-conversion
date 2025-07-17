#!/bin/bash
#FLUX: --job-name=redistricting
#FLUX: -N=2
#FLUX: -t=86400
#FLUX: --urgency=16

module load julia/1.6.1
julia mggg.jl
