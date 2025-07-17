#!/bin/bash
#FLUX: --job-name=rainbow-nunchucks-1419
#FLUX: --queue=a800
#FLUX: -t=35996400
#FLUX: --urgency=16

module load julia-1.7.1
project_dir=~/research/AD_Excitation
julia --project=${project_dir} ${project_dir}/project/groundstate.jl \
      --alg "VUMPS" \
      --model "J1J2(7,0.4)" \
      --chi 128 \
      --targchi 128 \
      --if2site false \
      --if4site false
