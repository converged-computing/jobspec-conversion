#!/bin/bash
#FLUX: --job-name=noisy_small_1
#FLUX: -c=16
#FLUX: --queue=gpusmall
#FLUX: -t=6000
#FLUX: --priority=16

echo $SLURM_ARRAY_TASK_ID
module load pytorch/1.11
python train.py -p config/params.yaml -alpha $SLURM_ARRAY_TASK_ID
