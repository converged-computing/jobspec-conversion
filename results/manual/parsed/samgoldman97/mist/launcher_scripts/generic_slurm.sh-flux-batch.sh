#!/bin/bash
#FLUX: --job-name=butterscotch-knife-9890
#FLUX: --urgency=16

conda activate ms-gen
echo "Cuda visible:"
echo $CUDA_VISIBLE_DEVICES
eval $CMD
