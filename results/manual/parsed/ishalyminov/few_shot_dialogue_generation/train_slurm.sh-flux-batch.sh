#!/bin/bash
#FLUX: --job-name=pusheena-peanut-butter-1468
#FLUX: --queue=amd-longq
#FLUX: --priority=16

CUDA_VERSION=cuda10.0
CUDA_VERSION_LONG=10.0.130
CUDNN_VERSION=7.4
module purge
module load shared
module load $CUDA_VERSION/blas/$CUDA_VERSION_LONG $CUDA_VERSION/fft/$CUDA_VERSION_LONG $CUDA_VERSION/nsight/$CUDA_VERSION_LONG $CUDA_VERSION/profiler/$CUDA_VERSION_LONG $CUDA_VERSION/toolkit/$CUDA_VERSION_LONG cudnn/$CUDNN_VERSION
cd /home/ishalyminov/data/dialog_knowledge_transfer &&  /home/ishalyminov/miniconda3/envs/dialog_knowledge_transfer3/bin/python -m train $@
exit 0
