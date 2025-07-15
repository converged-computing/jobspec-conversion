#!/bin/bash
#FLUX: --job-name="PC_2D_daint"
#FLUX: --queue=normal
#FLUX: -t=12600
#FLUX: --priority=16

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia -O3 --check-bounds=no --project=../.. ./PorousConvection_2D_xpu_daint.jl 511 1023 4000
