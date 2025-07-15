#!/bin/bash
#FLUX: --job-name=joyous-frito-4818
#FLUX: --urgency=16

hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
echo $SLURM_ARRAY_TASK_ID
