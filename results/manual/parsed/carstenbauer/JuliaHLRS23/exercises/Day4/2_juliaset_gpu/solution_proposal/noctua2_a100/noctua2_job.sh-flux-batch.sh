#!/bin/bash
#FLUX: --job-name=juliaset_gpu
#FLUX: -c=16
#FLUX: --queue=dgx
#FLUX: -t=900
#FLUX: --urgency=16

ml r
ml lang JuliaHPC
julia --project ../juliaset_gpu.jl
