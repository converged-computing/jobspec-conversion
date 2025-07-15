#!/bin/bash
#FLUX: --job-name=doopy-punk-6040
#FLUX: --priority=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
cd ../build/Linux
make -j 32
