#!/bin/bash
#FLUX: --job-name=03_generate_sdms
#FLUX: -c=64
#FLUX: -t=7200
#FLUX: --priority=16

module load StdEnv/2020
module load julia/1.9.1
cd $HOME/projects/def-tpoisot/2022-SpatialProbabilisticMetaweb/
julia --project --threads=63 -e 'CAN = true; quiet = true; include("03_generate_sdms.jl")'
