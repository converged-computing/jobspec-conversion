#!/bin/bash
#FLUX: --job-name=spicy-peas-6110
#FLUX: -t=600
#FLUX: --priority=16

echo "I'm alive!" >> imalive.txt
module load julia/1.2.0
module load
julia example.jl
