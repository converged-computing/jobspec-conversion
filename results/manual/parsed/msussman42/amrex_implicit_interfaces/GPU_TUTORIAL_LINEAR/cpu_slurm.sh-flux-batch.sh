#!/bin/bash
#FLUX: --job-name=cpu test
#FLUX: --queue=quicktest
#FLUX: -t=240
#FLUX: --urgency=16

echo module load cuda-12.2
module load cuda-12.2
module list 
echo nvcc --version
nvcc --version
echo /usr/bin/nvidia-smi -L
echo /usr/bin/nvidia-smi --query-gpu=gpu_name,gpu_bus_id,vbios_version --format=csv
echo /usr/bin/nvidia-smi --query-gpu=timestamp,name,pci.bus_id,driver_version --format=csv
gcc --version 
srun ~/CNSWAVE/CNS_CPU inputs
