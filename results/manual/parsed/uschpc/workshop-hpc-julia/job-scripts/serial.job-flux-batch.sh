#!/bin/bash
#FLUX: --job-name=bloated-lentil-6944
#FLUX: --queue=main
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load julia/1.10.2
julia script.jl
