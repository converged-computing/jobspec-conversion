#!/bin/bash
#FLUX: --job-name=frigid-lemur-1530
#FLUX: --urgency=16

source /etc/profile
module load julia/1.8.5
julia Simulation_distrv1Lin.jl
