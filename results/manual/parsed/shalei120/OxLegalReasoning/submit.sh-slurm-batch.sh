#!/bin/bash
#FLUX: --job-name=Legal
#FLUX: --urgency=16

module load python/anaconda3/2019.03
module load gpu/cuda/10.1.243
module load gpu/cudnn/7.5.0__cuda-10.0
echo "CUDA Device(s) : $CUDA_VISIBLE_DEVICES"
nvidia-smi
python3 main.py -m transformer
