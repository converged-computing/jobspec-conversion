#!/bin/bash
#FLUX: --job-name=carnivorous-dog-6098
#FLUX: -t=5400
#FLUX: --urgency=16

module load julia
julia z_tsptw_experiment.jl $setnum $instance
