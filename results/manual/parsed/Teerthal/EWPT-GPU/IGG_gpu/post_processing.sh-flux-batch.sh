#!/bin/bash
#FLUX: --job-name=gassy-staircase-4250
#FLUX: -c=26
#FLUX: -t=240
#FLUX: --urgency=16

time julia -t 26 post_sim.jl
