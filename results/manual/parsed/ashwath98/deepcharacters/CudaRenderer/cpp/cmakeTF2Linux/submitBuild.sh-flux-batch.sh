#!/bin/bash
#FLUX --job-name=fugly-nalgas-6731
#FLUX --queue=gpu20
#FLUX -t=172800
#FLUX --urgency=16

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
./createBuildLinux.sh --use-gpu ${CUDA_VISIBLE_DEVICES}
