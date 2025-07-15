#!/bin/bash
#FLUX: --job-name=pusheena-diablo-5514
#FLUX: --urgency=16

hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
echo $SLURM_ARRAY_TASK_ID
