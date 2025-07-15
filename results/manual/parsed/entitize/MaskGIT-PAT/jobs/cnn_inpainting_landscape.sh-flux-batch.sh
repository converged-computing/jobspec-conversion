#!/bin/bash
#FLUX: --job-name=fugly-caramel-0085
#FLUX: -t=86400
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

source ~/.bashrc
module load cuda/11.8
module load gcc/9.2.0
module load clang/16.0.4
export CUDA_VISIBLE_DEVICES=0
cd ~/MaskGIT-PAT
python cnn_inpainting.py \
    --epochs 100 \
    --experiment-name landscape_cnn_sa \
    --dataset-path /groups/mlprojects/pat/landscape256_split \
    --image-channels 3 \
    --image-size 64 \
    --spatial-aliasing
    # --experiment-name cnn_inpainting_check_versions \
