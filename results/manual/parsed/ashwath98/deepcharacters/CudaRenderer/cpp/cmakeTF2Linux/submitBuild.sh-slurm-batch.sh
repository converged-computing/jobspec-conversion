#!/bin/bash
#FLUX: --job-name=wobbly-squidward-2529
#FLUX: --queue=gpu20
#FLUX: -t=172800
#FLUX: --urgency=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
./createBuildLinux.sh --use-gpu ${CUDA_VISIBLE_DEVICES}
