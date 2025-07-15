#!/bin/bash
#FLUX: --job-name=anxious-rabbit-5816
#FLUX: --priority=16

source /etc/profile
module load julia/1.8.5
julia Simulation_distrv1Lin.jl
