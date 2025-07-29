#!/bin/bash
#SBATCH --job-name=job_name
#SBATCH --output=./eulerlog/o_device_job_name_%j.out
#SBATCH --error=./eulerlog/o_device_job_name_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=80GB
#SBATCH --time=10-16:00:00
#SBATCH --partition=lianglab
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=euler[01-16],euler[20-28]

source ~/.bashrc
conda activate /srv/home/zxu444/anaconda3/envs/lmeval
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
run_command
