#!/bin/bash
#FLUX --job-name=bumfuzzled-lizard-3769
#FLUX -c=26
#FLUX -t=240
#FLUX --urgency=16

time julia -t 26 post_sim.jl
