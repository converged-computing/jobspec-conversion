#!/bin/bash
#FLUX: --job-name="convect3D"
#FLUX: --queue=normal
#FLUX: -t=10800
#FLUX: --priority=16

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
srun julia -O3 PorousConvection_3D_xpu.jl
