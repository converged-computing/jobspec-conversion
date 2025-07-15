#!/bin/bash
#FLUX: --job-name=viz_3D_porous_convection
#FLUX: --queue=normal
#FLUX: -t=600
#FLUX: --urgency=16

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
srun julia --project=../.. ./visualise.jl
