#!/bin/bash
#FLUX --job-name=butterscotch-destiny-0150
#FLUX --queue=gpu20
#FLUX -t=172800
#FLUX --urgency=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
cd /HPS/RTMPC/work/CudaRenderer/cpp/build/Linux
make -j 32
