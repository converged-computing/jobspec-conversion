#!/bin/bash
#FLUX --job-name=bricky-muffin-0128
#FLUX -c=12
#FLUX --queue=ai
#FLUX --urgency=16

GPU_COUNT=$(grep -Po "^[^\#].+gpus = \K([0-9]+)" config.py)
echo $(hostname) $CUDA_VISIBLE_DEVICES $GPU_COUNT
singularity exec /public/DL_Data/cnic_ai.img python train.py
