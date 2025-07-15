#!/bin/bash
#FLUX: --job-name=bricky-noodle-8453
#FLUX: --priority=16

module purge
module load julia/1.9.0
echo `date +%F-%T`
julia ~/SpatialRust/scripts/GA/runBaseScenario.jl
