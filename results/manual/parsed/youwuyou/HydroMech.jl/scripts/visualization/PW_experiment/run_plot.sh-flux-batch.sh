#!/bin/bash
#FLUX: --job-name=plotting
#FLUX: -t=172800
#FLUX: --priority=16

module load cuda-11.8.0-gcc-11.2.0-kh2t6kp
julia --project HighResolutionPlot.jl
