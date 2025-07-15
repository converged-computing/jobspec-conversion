#!/bin/bash
#FLUX: --job-name=dinosaur-banana-6717
#FLUX: -t=600
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

source ~/.bashrc
module load cuda/11.8
module load gcc/9.2.0
module load clang/16.0.4
export CUDA_VISIBLE_DEVICES=0
cd ~/MaskGIT-PAT
python load_and_predict_cnn.py \
    --result_directory /groups/mlprojects/pat/cnn_limited_view_onethird \
    --dataset-path /groups/mlprojects/pat/pat_norm_crop \
    --image-channels 1 \
    --image-size 64 \
    --model-path /home/mshao/MaskGIT-PAT/wandb/run-20231120_222532-ixbhzc58/files/model-best.h5 \
    --limited-view
    # --model-path wandb/latest-run/files/model-best.h5 \
    # --experiment-name cnn_inpainting_check_versions \
