#!/bin/bash
#FLUX: --job-name=conspicuous-cattywampus-5175
#FLUX: -c=2
#FLUX: --queue=hgx
#FLUX: -t=600
#FLUX: --urgency=16

nvidia-smi
echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
