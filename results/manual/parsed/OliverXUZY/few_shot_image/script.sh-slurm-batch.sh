#!/bin/bash
#SBATCH --job-name=train_val
#SBATCH --output=./log/l_device_%j.out
#SBATCH --error=./log/e_device_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=40GB
#SBATCH --time=10-16:00:00
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --exclude=euler[01-16],euler[24-27]

source ~/.bashrc
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
python runVisionLM.py --config=configs/VL/tiered-imagenet.yaml --do_test
