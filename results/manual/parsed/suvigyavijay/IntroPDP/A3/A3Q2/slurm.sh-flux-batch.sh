#!/bin/bash
#FLUX: --job-name="gaussian_kde_run"
#FLUX: --queue=general-compute
#FLUX: -t=3600
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0'

echo "JOB_ID=$SLURM_JOB_ID"
echo "hostname=`hostname`"
echo "ARCH=$CCR_ARCH"
date -u
nvidia-smi
echo "GPU INFO:"
nvidia-smi --query-gpu=gpu_name,driver_version,memory.total --format=csv
printf "\n"
module load cuda
export CUDA_VISIBLE_DEVICES=0
echo "Running on GPU with n=100000, h=0.1"
./a3 100000 0.1
echo "Running on GPU with n=200000, h=0.1"
./a3 200000 0.1
echo "Running on GPU with n=400000, h=0.1"
./a3 400000 0.1
echo "Running on GPU with n=1000000, h=0.1"
./a3 1000000 0.1
echo "Running on GPU with n=2000000, h=0.1"
./a3 2000000 0.1
echo "Running on GPU with n=4000000, h=0.1"
./a3 4000000 0.1
echo "Running on CPU with n=10000, h=0.1"
./a3_cpu 10000 0.1
echo "Running on GPU with n=10000, h=0.1"
./a3 10000 0.1
echo "Running on CPU with n=20000, h=0.1"
./a3_cpu 20000 0.1
echo "Running on GPU with n=20000, h=0.1"
./a3 20000 0.1
echo "Running on CPU with n=30000, h=0.1"
./a3_cpu 30000 0.1
echo "Running on GPU with n=30000, h=0.1"
./a3 30000 0.1
echo "Running on CPU with n=40000, h=0.1"
./a3_cpu 40000 0.1
echo "Running on GPU with n=40000, h=0.1"
./a3 40000 0.1
echo "Running on CPU with n=50000, h=0.1"
./a3_cpu 50000 0.1
echo "Running on GPU with n=50000, h=0.1"
./a3 50000 0.1
echo "Running on CPU with n=60000, h=0.1"
./a3_cpu 60000 0.1
echo "Running on GPU with n=60000, h=0.1"
./a3 60000 0.1
echo "Running on CPU with n=70000, h=0.1"
./a3_cpu 70000 0.1
echo "Running on GPU with n=70000, h=0.1"
./a3 70000 0.1
echo "Running on CPU with n=80000, h=0.1"
./a3_cpu 80000 0.1
echo "Running on GPU with n=80000, h=0.1"
./a3 80000 0.1
echo "Running on CPU with n=90000, h=0.1"
./a3_cpu 90000 0.1
echo "Running on GPU with n=90000, h=0.1"
./a3 90000 0.1
echo "Running on CPU with n=100000, h=0.1"
./a3_cpu 100000 0.1
echo "Running on GPU with n=100000, h=0.1"
./a3 100000 0.1
