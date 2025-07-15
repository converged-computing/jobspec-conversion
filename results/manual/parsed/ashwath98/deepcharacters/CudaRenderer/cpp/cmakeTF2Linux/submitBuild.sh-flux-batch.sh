#!/bin/bash
#FLUX: --job-name=faux-caramel-3385
#FLUX: --urgency=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
./createBuildLinux.sh --use-gpu ${CUDA_VISIBLE_DEVICES}
