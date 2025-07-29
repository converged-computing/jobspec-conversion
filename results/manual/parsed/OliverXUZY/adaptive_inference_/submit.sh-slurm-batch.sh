#!/bin/bash
#SBATCH --job-name=ada_inf
#SBATCH --output=./eulerlog/o_device_%j.out
#SBATCH --error=./eulerlog/o_device_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=80GB
#SBATCH --time=10-16:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=euler[01-09],euler[11-12],euler[14],euler[24-27]

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
