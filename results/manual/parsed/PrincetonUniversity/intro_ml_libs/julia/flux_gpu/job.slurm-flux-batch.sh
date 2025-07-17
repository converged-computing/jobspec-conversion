#!/bin/bash
#FLUX: --job-name=flux-gpu
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load julia/1.5.0 cudatoolkit/11.0 cudnn/cuda-11.0/8.0.2
julia conv_mnist.jl
