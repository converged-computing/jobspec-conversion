#!/bin/bash
#FLUX: --job-name=pat_cnn_dataset_norm
#FLUX: -t=3600
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

source ~/.bashrc
module load cuda/11.8
module load gcc/9.2.0
module load clang/16.0.4
export CUDA_VISIBLE_DEVICES=0
cd ~/MaskGIT-PAT
python create_cnn_dataset.py
    # --experiment-name cnn_inpainting_check_versions \
