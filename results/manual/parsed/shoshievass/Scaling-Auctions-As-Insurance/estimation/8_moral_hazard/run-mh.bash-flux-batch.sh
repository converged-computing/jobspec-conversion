#!/bin/bash
#FLUX: --job-name=hazard
#FLUX: -t=172800
#FLUX: --priority=16

export JLGUROBI='true'

module load julia/1.7.3 gurobi
export JLGUROBI=true
julia --threads=4 --project 8-hazard.jl
