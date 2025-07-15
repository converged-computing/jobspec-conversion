#!/bin/bash
#FLUX: --job-name=ensemble
#FLUX: -t=18000
#FLUX: --priority=16

export JULIA_DEPOT_PATH='/project/def-gonzalez/mcatchen/JuliaEnvironments/COBees'
export CLUSTER='true'

module load cuda
module load julia/1.8.5
module load cudnn 
export JULIA_DEPOT_PATH="/project/def-gonzalez/mcatchen/JuliaEnvironments/COBees"
export CLUSTER="true"
julia fit_ensemble.jl
