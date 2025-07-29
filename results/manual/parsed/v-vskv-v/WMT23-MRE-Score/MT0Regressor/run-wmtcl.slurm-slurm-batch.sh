#!/bin/bash
#FLUX: --job-name=cl-labse-train-regressor
#FLUX: -c=16
#FLUX: --queue=intel-a100-pci3
#FLUX: -t=259200
#FLUX: --urgency=16

echo "Starting at `date` on `hostname` at `pwd`"
echo "Job name: $SLURM_JOB_NAME Job ID: $SLURM_JOB_ID"
echo "==============================="
nvidia-smi
echo "==============================="
echo "Using GPUs: $CUDA_VISIBLE_DEVICES"
echo "==============================="
accelerate launch --config_file="2xgpu.yaml" train.py --checkpoint="./wmtcl.ckpt" --save-file-name="mt0-large-wmtcl-labse.pth"
