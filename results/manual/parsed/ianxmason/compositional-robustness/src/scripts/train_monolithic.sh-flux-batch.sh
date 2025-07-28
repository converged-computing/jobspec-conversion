#!/bin/bash
#FLUX: --job-name=blank-peanut-butter-6161
#FLUX: -n=4
#FLUX: -t=172800
#FLUX: --urgency=16

hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
echo $SLURM_ARRAY_TASK_ID
