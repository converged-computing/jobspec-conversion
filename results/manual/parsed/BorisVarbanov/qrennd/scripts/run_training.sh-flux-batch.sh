#!/bin/bash
#FLUX: --job-name="qrennd-train-test"
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --priority=16

module load 2022r2
module load python
module load openmpi
module load py-tensorflow
previous=$(/usr/bin/nvidia-smi --query-accounted-apps='gpu_utilization,mem_utilization,max_memory_usage,time' --format='csv' | /usr/bin/tail -n '+2')
srun --mpi=pmix python train_qrennd.py
/usr/bin/nvidia-smi --query-accounted-apps='gpu_utilization,mem_utilization,max_memory_usage,time' --format='csv' | /usr/bin/grep -v -F "$previous"
