#!/bin/bash
#FLUX: --job-name="PC_3D 127 2000 false true"
#FLUX: --queue=normal
#FLUX: -t=14400
#FLUX: --priority=16

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia -O3 --check-bounds=no --project=../.. ./PorousConvection_3D_xpu.jl
