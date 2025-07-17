#!/bin/bash
#FLUX: --job-name=debug-basescen
#FLUX: --queue=debug
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load julia/1.8.2
echo `date +%F-%T`
julia ~/SpatialRust/scripts/GA/runFittest.jl 0.5 0.02 "shorttprofit" 0.48
