#!/bin/bash
#FLUX: --job-name=moolicious-train-0367
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=165600
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate brainseg
cd /scratch1/hedongzh/brainseg
echo "Checking Cuda, GPU USED?"
python -c 'import torch; print(torch.cuda.is_available()); print(torch.cuda.current_device()); print(torch.cuda.get_device_name(0))'
nvidia-smi
echo "Running: python " $1
python $1
