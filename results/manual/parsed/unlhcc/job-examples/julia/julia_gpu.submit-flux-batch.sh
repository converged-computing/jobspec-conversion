#!/bin/bash
#FLUX: --job-name=julia_gpu_example
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --priority=16

module load julia/1.9 cuda/12.2 
julia -e 'import Pkg; Pkg.add("CUDA")'
julia julia_gpu.jl
