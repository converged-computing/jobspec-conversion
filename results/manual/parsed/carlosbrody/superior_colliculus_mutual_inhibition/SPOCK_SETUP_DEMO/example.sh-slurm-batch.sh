#!/bin/bash
#FLUX: --job-name=julia-example
#FLUX: --queue=Brody
#FLUX: -t=600
#FLUX: --urgency=16

echo "I'm alive!" >> imalive.txt
module load julia/1.2.0
module load
julia example.jl
