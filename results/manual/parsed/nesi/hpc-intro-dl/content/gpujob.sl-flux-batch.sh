#!/bin/bash
#FLUX: --job-name=purple-bicycle-0271
#FLUX: -c=2
#FLUX: --queue=hgx
#FLUX: -t=600
#FLUX: --priority=16

nvidia-smi
echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
