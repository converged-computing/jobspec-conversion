#!/bin/bash
#FLUX: --job-name="Diff2D_xpu"
#FLUX: --queue=normal
#FLUX: -t=300
#FLUX: --priority=16

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia -O3 --check-bounds=no --project=../..  l8_diffusion_2D_perf_xpu.jl true
srun julia -O3 --check-bounds=no --project=../..  l8_diffusion_2D_perf_xpu.jl false
