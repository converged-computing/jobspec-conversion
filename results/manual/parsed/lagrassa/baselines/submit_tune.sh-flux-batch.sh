#!/bin/bash
#FLUX: --job-name=muffled-lamp-9357
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES=''

source /etc/profile
module load cuda-9.0
export CUDA_VISIBLE_DEVICES=""
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
python tune.py naf_fetchpush
