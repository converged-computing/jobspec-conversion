#!/bin/bash
#FLUX: --job-name="convect2D"
#FLUX: --queue=normal
#FLUX: -t=10800
#FLUX: --priority=16

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia --check-bounds=no -O3 PorousConvection_2D_xpu.jl
