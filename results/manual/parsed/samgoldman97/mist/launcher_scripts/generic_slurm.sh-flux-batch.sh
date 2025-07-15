#!/bin/bash
#FLUX: --job-name=angry-general-2870
#FLUX: --priority=16

conda activate ms-gen
echo "Cuda visible:"
echo $CUDA_VISIBLE_DEVICES
eval $CMD
