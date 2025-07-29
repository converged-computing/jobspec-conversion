#!/bin/bash
#FLUX: --job-name=gassy-salad-3891
#FLUX: -c=2
#FLUX: --queue=hgx
#FLUX: -t=600
#FLUX: --urgency=16

nvidia-smi
echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
