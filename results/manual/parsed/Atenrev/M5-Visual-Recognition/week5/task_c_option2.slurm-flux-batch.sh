#!/bin/bash
#FLUX: --job-name=astute-staircase-1355
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python task_a.py \
    --mode symmetric \
    --output_path "outputs_task_symmetric/" \
    --dataset_path "$1" \
    --train_size 0.6 \
    --val_size 1.0 \
    --random_subset True \
	--image_encoder resnet_18 \
    --text_encoder bert \
    --embedding_size 256 \
	--batch_size 64 \
    --epochs 15 \
    --lr 0.0001 \
    --weight_decay 0.0001
