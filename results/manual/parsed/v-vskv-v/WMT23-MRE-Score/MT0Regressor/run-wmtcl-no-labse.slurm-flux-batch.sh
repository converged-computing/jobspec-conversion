#!/bin/bash
#FLUX: --job-name=cl-no-labse-train-regressor
#FLUX: -c=16
#FLUX: --queue=intel-gpu
#FLUX: -t=259200
#FLUX: --priority=16

echo "Starting at `date` on `hostname` at `pwd`"
echo "Job name: $SLURM_JOB_NAME Job ID: $SLURM_JOB_ID"
echo "==============================="
nvidia-smi
echo "==============================="
echo "Using GPUs: $CUDA_VISIBLE_DEVICES"
echo "==============================="
accelerate launch --config_file="8xgpu.yaml" train.py --checkpoint="wmtcl.ckpt" --no-use-labse --save-file-name="mt0-large-wmtcl-no-labse.pth"
