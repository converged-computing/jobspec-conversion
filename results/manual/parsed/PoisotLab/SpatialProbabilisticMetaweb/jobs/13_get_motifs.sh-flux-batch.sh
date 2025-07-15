#!/bin/bash
#FLUX: --job-name=13_get_S4
#FLUX: -c=64
#FLUX: -t=7200
#FLUX: --priority=16

module load StdEnv/2020
module load julia/1.9.1
cd $HOME/projects/def-tpoisot/2022-SpatialProbabilisticMetaweb/
julia --project --threads=63 -e 'MOTIF = :S4; TOTAL_JOBS = 500; JOBARRAY = true; CAN = true; quiet = true; include("13_get_motifs.jl")'
