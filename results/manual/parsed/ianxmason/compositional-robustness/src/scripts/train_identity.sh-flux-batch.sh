#!/bin/bash
#FLUX: --job-name=red-butter-9058
#FLUX: -n=4
#FLUX: -t=86400
#FLUX: --urgency=16

hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
echo $SLURM_ARRAY_TASK_ID
