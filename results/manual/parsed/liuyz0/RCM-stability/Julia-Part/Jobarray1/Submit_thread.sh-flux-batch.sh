#!/bin/bash
#FLUX: --job-name=conspicuous-mango-2347
#FLUX: --urgency=16

source /etc/profile
module load julia/1.8.5
julia --threads 48 SimulationThread.jl
