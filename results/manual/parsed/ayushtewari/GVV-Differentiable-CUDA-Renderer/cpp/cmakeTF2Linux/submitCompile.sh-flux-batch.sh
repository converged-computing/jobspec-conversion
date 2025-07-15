#!/bin/bash
#FLUX: --job-name=blank-leader-1846
#FLUX: --priority=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
cd /HPS/RTMPC/work/CudaRenderer/cpp/build/Linux
make -j 32
