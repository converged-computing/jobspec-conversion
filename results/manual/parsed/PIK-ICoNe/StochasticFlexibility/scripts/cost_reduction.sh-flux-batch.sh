#!/bin/bash
#FLUX: --job-name=moolicious-lemon-1098
#FLUX: -t=7200
#FLUX: --priority=16

module load julia
srun julia --threads=1 ./code/StochasticFlexibility/experiments/cost_reduction.jl
srun julia --threads=1 ./code/StochasticFlexibility/experiments/cost_reduction_sankey.jl
