#!/bin/bash
#FLUX --job-name=anxious-parsnip-0110
#FLUX -N=2
#FLUX -t=259200
#FLUX --urgency=16

module load julia
srun julia ./code/StochasticFlexibility/experiments/investment_sensitivity_parallel.jl
