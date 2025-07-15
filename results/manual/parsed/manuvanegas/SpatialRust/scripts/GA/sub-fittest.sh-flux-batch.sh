#!/bin/bash
#FLUX: --job-name=gloopy-taco-9776
#FLUX: --priority=16

module purge
module load julia/1.8.2
echo `date +%F-%T`
julia ~/SpatialRust/scripts/GA/runFittest.jl 0.5 0.02 "shorttprofit" 0.48
