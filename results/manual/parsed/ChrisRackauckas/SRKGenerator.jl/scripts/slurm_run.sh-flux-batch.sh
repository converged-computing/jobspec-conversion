#!/bin/bash
#FLUX: --job-name=SRK
#FLUX: --queue=gpu-shared
#FLUX: --urgency=16

module load cuda/7.0
module load cmake
/home/crackauc/julia-3c9d75391c/bin/julia /home/crackauc/.julia/v0.5/SRKGenerator/test/runtests.jl 2496 $1 $2
