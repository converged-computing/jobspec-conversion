#!/bin/bash
#SBATCH --job-name=NVIDIASMI_GPULab
#SBATCH --account=True
#SBATCH --output=runjob/NVIDIASMI_GPULab.o%j
#SBATCH --error=runjob/NVIDIASMI_GPULab.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:59:59

source set_environment
power/power_measure.sh "nvidia-smi --id=0 --query-gpu=timestamp,temperature.gpu,power.draw --format=csv --filename=testpower.csv --loop=1" "kernel/bin/gemm_cuda_bench -M fp16 -A fp16 -I 100 32768 32768 32768"
