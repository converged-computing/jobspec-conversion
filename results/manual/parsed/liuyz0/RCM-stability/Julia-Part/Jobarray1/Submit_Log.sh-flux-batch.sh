#!/bin/bash
#FLUX: --job-name=psycho-caramel-4915
#FLUX: --priority=16

source /etc/profile
module load julia/1.8.5
julia Simulation_distrv1Log.jl
