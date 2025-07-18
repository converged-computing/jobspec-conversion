#!/bin/bash
#FLUX: --job-name=NVIDIASMI_GPULab
#FLUX: --queue=gpu-a100
#FLUX: -t=7199
#FLUX: --urgency=16

source set_environment
power/power_measure.sh "nvidia-smi --id=0 --query-gpu=timestamp,temperature.gpu,power.draw --format=csv --filename=testpower.csv --loop=1" "kernel/bin/gemm_cuda_bench -M fp16 -A fp16 -I 100 32768 32768 32768"
