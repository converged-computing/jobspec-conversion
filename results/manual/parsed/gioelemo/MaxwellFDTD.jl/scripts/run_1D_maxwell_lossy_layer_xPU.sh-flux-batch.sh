#!/bin/bash
#FLUX: --job-name="1D_additive_source_lossy_layer"
#FLUX: --queue=normal
#FLUX: -t=1800
#FLUX: --priority=16

module load daint-gpu
module load Julia/1.9.3-CrayGNU-21.09-cuda
srun julia -O3 1D_additive_source_lossy_layer.jl
