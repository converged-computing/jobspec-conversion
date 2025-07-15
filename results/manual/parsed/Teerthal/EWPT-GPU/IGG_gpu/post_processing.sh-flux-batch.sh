#!/bin/bash
#FLUX: --job-name=expensive-malarkey-9522
#FLUX: --priority=16

time julia -t 26 post_sim.jl
