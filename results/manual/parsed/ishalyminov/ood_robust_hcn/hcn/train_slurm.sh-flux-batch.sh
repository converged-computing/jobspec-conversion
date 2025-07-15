#!/bin/bash
#FLUX: --job-name=carnivorous-nalgas-5899
#FLUX: --queue=amd-longq
#FLUX: --priority=16

CUDA_VERSION=cuda90
CUDA_VERSION_LONG=9.0.176
CUDNN_VERSION=7.0
module purge
module load shared
module load $CUDA_VERSION/blas/$CUDA_VERSION_LONG $CUDA_VERSION/fft/$CUDA_VERSION_LONG $CUDA_VERSION/nsight/$CUDA_VERSION_LONG $CUDA_VERSION/profiler/$CUDA_VERSION_LONG $CUDA_VERSION/toolkit/$CUDA_VERSION_LONG cudnn/$CUDNN_VERSION
cd /home/ishalyminov/data/ood_robust/hcn && /home/ishalyminov/Envs/ood_robust/bin/python -m train $@
exit 0
