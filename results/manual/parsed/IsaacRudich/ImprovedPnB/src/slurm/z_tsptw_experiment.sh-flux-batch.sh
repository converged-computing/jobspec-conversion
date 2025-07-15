#!/bin/bash
#FLUX: --job-name=astute-buttface-6543
#FLUX: -t=5400
#FLUX: --priority=16

module load julia
julia z_tsptw_experiment.jl $setnum $instance
