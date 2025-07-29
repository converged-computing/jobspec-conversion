#!/bin/bash
#FLUX --job-name=milky-kerfuffle-9001
#FLUX -c=48
#FLUX --urgency=16

source /etc/profile
module load julia/1.8.5
julia --threads 48 SimulationThread.jl
