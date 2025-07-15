#!/bin/bash
#FLUX: --job-name=fugly-milkshake-8565
#FLUX: -c=16
#FLUX: --queue=dgx
#FLUX: --priority=16

ml r
ml lang JuliaHPC
julia --project ../juliaset_gpu.jl
