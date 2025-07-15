#!/bin/bash
#FLUX: --job-name=stinky-blackbean-4198
#FLUX: --urgency=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
cd /HPS/RTMPC/work/CudaRenderer/cpp/build/Linux
make -j 32
