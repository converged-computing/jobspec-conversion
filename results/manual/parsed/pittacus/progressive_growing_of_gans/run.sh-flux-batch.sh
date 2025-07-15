#!/bin/bash
#FLUX: --job-name=astute-leg-0424
#FLUX: --urgency=16

GPU_COUNT=$(grep -Po "^[^\#].+gpus = \K([0-9]+)" config.py)
echo $(hostname) $CUDA_VISIBLE_DEVICES $GPU_COUNT
singularity exec /public/DL_Data/cnic_ai.img python train.py
