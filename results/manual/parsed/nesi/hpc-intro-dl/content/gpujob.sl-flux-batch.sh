#!/bin/bash
#FLUX: --job-name=frigid-kerfuffle-2950
#FLUX: -c=2
#FLUX: --queue=hgx
#FLUX: -t=600
#FLUX: --urgency=16

nvidia-smi
echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
