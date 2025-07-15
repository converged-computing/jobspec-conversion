#!/bin/bash
#FLUX: --job-name=gassy-spoon-2272
#FLUX: --priority=16

hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
echo $SLURM_ARRAY_TASK_ID
