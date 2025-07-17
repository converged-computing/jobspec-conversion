#!/bin/bash
#FLUX: --job-name=julia_gpu
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module load julia/1.8.2
julia svd.jl
