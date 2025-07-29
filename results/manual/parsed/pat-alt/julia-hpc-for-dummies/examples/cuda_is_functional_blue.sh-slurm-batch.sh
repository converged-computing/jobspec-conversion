#!/bin/bash
#FLUX: --job-name=CUDA is functional
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --urgency=16

module load 2023r1
source examples/slurm_header.sh
previous=$(/usr/bin/nvidia-smi --query-accounted-apps='gpu_utilization,mem_utilization,max_memory_usage,time' --format='csv' | /usr/bin/tail -n '+2')
srun julia --project=examples examples/cuda_is_functional.jl > examples/cuda_is_functional_blue.log
/usr/bin/nvidia-smi --query-accounted-apps='gpu_utilization,mem_utilization,max_memory_usage,time' --format='csv' | /usr/bin/grep -v -F "$previous"
