#!/bin/bash
#FLUX: --job-name=conspicuous-poodle-8567
#FLUX: --priority=16

source set_environment
power/power_measure.sh "nvidia-smi --id=0 --query-gpu=timestamp,temperature.gpu,power.draw --format=csv --filename=testpower.csv --loop=1" "kernel/bin/gemm_cuda_bench -M fp16 -A fp16 -I 100 32768 32768 32768"
