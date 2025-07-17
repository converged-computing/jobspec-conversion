#!/bin/bash
#FLUX: --job-name=hanky-cat-6086
#FLUX: --queue=gpu20
#FLUX: -t=172800
#FLUX: --urgency=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
./createBuildLinux.sh --use-gpu ${CUDA_VISIBLE_DEVICES}
