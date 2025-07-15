#!/bin/bash
#FLUX: --job-name=carnivorous-hippo-5107
#FLUX: -c=16
#FLUX: --urgency=16

source ~/.bashrc
(
    while true; do
        nvidia-smi | tee -a ./log/gpu_usage_${SLURM_JOB_ID}.log
        sleep 600  # Log every 600 seconds
    done
) &
monitor_pid=$!
echo "======== testing CUDA available ========"
echo "running on machine: " $(hostname -s)
python - << EOF
import torch
print(torch.cuda.is_available())
print(torch.cuda.device_count())
print(torch.cuda.current_device())
print(torch.cuda.device(0))
print(torch.cuda.get_device_name(0))
EOF
echo "======== run with different inputs ========"
python train.py \
    -c '/srv/home/zxu444/vision/adaptive_inference/configs/resnet50_imagenet.yaml' \
    -n 'train_resnet50_imagenet' \
    -pf 1 \
