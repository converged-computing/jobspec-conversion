#!/bin/bash
#FLUX: --job-name=goodbye-staircase-7619
#FLUX: -c=16
#FLUX: --queue=dgx
#FLUX: --urgency=16

ml r
ml lang JuliaHPC
julia --project ../juliaset_gpu.jl
