#!/bin/bash
#FLUX: --job-name=buttery-avocado-4397
#FLUX: -t=86400
#FLUX: --urgency=16

export JULIA_DEPOT_PATH='/project/def-gonzalez/mcatchen/JuliaEnvironments/COBees'
export CLUSTER='true'

module load cuda
module load julia/1.8.5
module load cudnn 
export JULIA_DEPOT_PATH="/project/def-gonzalez/mcatchen/JuliaEnvironments/COBees"
export CLUSTER="true"
julia ae_tuning.jl
