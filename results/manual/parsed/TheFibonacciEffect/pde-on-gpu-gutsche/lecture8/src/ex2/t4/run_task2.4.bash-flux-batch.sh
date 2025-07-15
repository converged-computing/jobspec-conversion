#!/bin/bash
#FLUX: --job-name="strong_scaling"
#FLUX: --queue=normal
#FLUX: -t=3600
#FLUX: --priority=16

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia -O3 --check-bounds=no --project=../../.. l8_diffusion_2D_pref_multixpu._SC.jl
