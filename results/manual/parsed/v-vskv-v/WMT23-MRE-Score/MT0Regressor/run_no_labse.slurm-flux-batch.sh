#!/bin/bash
#FLUX: --job-name=no-labse-train-regressor
#FLUX: -c=32
#FLUX: --queue=intel-gpu
#FLUX: -t=259200
#FLUX: --urgency=16

echo "Starting at `date` on `hostname` at `pwd`"
echo "Job name: $SLURM_JOB_NAME Job ID: $SLURM_JOB_ID"
echo "==============================="
nvidia-smi
echo "==============================="
echo "Using GPUs: $CUDA_VISIBLE_DEVICES"
echo "==============================="
accelerate launch --config_file="4xgpu.yaml" train.py --no-use-labse --save-file-name="mt0-large-no-labse.pth" --batch-size=8
