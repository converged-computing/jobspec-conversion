#!/bin/bash
#FLUX: --job-name=genarch
#FLUX: -c=4
#FLUX: --queue=LKEBgpu
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load library/cuda/11.3/gcc.8.3.1
hostname
echo "Cuda devices: $CUDA_VISIBLE_DEVICES"
nvidia-smi
echo
python_interpreter=/exports/lkeb-hpc/csrao/miniconda3/envs/mri/bin/python3
$python_interpreter train.py
