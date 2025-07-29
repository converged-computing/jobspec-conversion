#!/bin/bash
#FLUX: --job-name=14
#FLUX: -c=8
#FLUX: --queue=cisds
#FLUX: -t=2592000
#FLUX: --urgency=16

julia -t8 ../../Basin.jl ../../input_files/dynamic/large_simulations/d_4_1400.dat
