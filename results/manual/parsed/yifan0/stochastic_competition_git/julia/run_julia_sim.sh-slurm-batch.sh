#!/bin/bash
#FLUX: --job-name=run_sim
#FLUX: --queue=sandybridge
#FLUX: -t=1200
#FLUX: --urgency=16

module load julia/1.8.5
/usr/bin/time -v julia -t 16 sim.jl
