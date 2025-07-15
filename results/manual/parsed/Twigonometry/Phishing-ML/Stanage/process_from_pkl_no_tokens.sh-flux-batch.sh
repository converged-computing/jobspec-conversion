#!/bin/bash
#FLUX: --job-name=process_from_pkl_no_tokens
#FLUX: -c=6
#FLUX: --queue=gpu-h100
#FLUX: -t=86400
#FLUX: --priority=16

export TRANSFORMERS_CACHE='/mnt/parscratch/users/$USERNAME/cache'

module load Anaconda3/2022.10
module load cuDNN/8.8.0.121-CUDA-12.0.0
nvcc --version
nvidia-smi
source /opt/apps/testapps/common/software/staging/Anaconda3/2022.10/bin/activate
conda activate pytorch
export TRANSFORMERS_CACHE=/mnt/parscratch/users/$USERNAME/cache
python process_from_pkl_no_tokens.py
