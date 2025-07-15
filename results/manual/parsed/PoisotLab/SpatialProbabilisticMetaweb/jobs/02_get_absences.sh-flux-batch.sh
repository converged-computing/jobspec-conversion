#!/bin/bash
#FLUX: --job-name=02_get_absences
#FLUX: -c=64
#FLUX: -t=28800
#FLUX: --priority=16

module load StdEnv/2020
module load julia/1.9.1
cd $HOME/projects/def-tpoisot/2022-SpatialProbabilisticMetaweb/
julia --project --threads=63 -e 'JOBARRAY = true; CAN = true; quiet = true; include("02_get_absences.jl")'
