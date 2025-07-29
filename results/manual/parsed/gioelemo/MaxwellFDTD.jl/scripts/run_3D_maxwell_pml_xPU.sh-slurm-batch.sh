#!/bin/bash
#FLUX: --job-name=3D_maxwell_pml_xPU
#FLUX: --queue=normal
#FLUX: -t=1800
#FLUX: --urgency=16

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
srun julia -O3 3D_maxwell_pml_xPU.jl
