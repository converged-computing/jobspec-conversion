#!/bin/bash
#FLUX: --job-name="MLJFlux on GPU"
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

module load 2023r1
previous=$(/usr/bin/nvidia-smi --query-accounted-apps='gpu_utilization,mem_utilization,max_memory_usage,time' --format='csv' | /usr/bin/tail -n '+2')
srun julia --project=examples examples/mljflux_gpu.jl > examples/mljflux_gpu.log
/usr/bin/nvidia-smi --query-accounted-apps='gpu_utilization,mem_utilization,max_memory_usage,time' --format='csv' | /usr/bin/grep -v -F "$previous"
