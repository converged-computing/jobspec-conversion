#!/bin/bash
#FLUX: --job-name=misunderstood-dog-9073
#FLUX: -N=2
#FLUX: -t=259200
#FLUX: --priority=16

module load julia
srun julia ./code/StochasticFlexibility/experiments/investment_sensitivity_parallel.jl
