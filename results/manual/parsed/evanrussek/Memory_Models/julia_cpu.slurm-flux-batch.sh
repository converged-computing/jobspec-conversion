#!/bin/bash
#FLUX: --job-name=tannou_new800
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load julia/1.9.1
julia --project=. tanoue_param_search.jl
