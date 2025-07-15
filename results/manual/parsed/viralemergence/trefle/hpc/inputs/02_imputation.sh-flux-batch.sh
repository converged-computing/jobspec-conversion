#!/bin/bash
#FLUX: --job-name=trefle-prediction
#FLUX: -c=40
#FLUX: -t=7200
#FLUX: --priority=16

module load StdEnv/2020 julia/1.5.2
julia --project -t 38 02_imputation.jl
