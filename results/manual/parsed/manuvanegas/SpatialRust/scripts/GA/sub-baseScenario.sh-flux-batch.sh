#!/bin/bash
#FLUX: --job-name=debug-basescen
#FLUX: --queue=debug
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load julia/1.9.0
echo `date +%F-%T`
julia ~/SpatialRust/scripts/GA/runBaseScenario.jl
