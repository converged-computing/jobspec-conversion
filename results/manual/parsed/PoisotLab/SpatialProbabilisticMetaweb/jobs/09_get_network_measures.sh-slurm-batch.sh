#!/bin/bash
#FLUX: --job-name=09_get_network_measures
#FLUX: -c=64
#FLUX: -t=21600
#FLUX: --urgency=16

module load StdEnv/2020
module load julia/1.9.1
cd $HOME/projects/def-tpoisot/2022-SpatialProbabilisticMetaweb/
julia --project --threads=63 -e 'CAN = true; quiet = true; include("09_get_network_measures.jl")'
