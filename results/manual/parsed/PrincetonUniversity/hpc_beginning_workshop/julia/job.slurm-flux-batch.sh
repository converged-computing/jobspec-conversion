#!/bin/bash
#FLUX: --job-name=serial_jl
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load julia/1.5.0
julia hello_world.jl
