#!/bin/bash
#FLUX: --job-name=1D
#FLUX: --queue=gpu_irmb
#FLUX: -t=86400
#FLUX: --priority=16

srun singularity run \
 --cleanenv \
 --env CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES \
 --nv \
 --nvccli \
 --app Parametric_PINN \
 parametric_nn.sif \
