#!/bin/bash
#FLUX --job-name=creamy-noodle-5875
#FLUX -t=7200
#FLUX --urgency=16

module load julia
srun julia --threads=1 ./code/StochasticFlexibility/experiments/cost_reduction.jl
srun julia --threads=1 ./code/StochasticFlexibility/experiments/cost_reduction_sankey.jl
