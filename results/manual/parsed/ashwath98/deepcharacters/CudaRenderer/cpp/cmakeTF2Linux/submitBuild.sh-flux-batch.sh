#!/bin/bash
#FLUX: --job-name=lovely-cupcake-6284
#FLUX: --priority=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
./createBuildLinux.sh --use-gpu ${CUDA_VISIBLE_DEVICES}
