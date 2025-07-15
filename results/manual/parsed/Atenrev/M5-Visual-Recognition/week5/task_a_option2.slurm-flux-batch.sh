#!/bin/bash
#FLUX: --job-name=psycho-caramel-2857
#FLUX: --priority=16

python task_a.py \
    --mode image_to_text  \
    --output_path "outputs_task_a/" \
    --dataset_path "$1" \
    --train_size 0.6 \
    --val_size 1.0 \
    --random_subset True \
	--image_encoder resnet_18 \
    --text_encoder bert \
    --embedding_size 256 \
	--batch_size 64 \
    --epochs 15 \
    --lr 0.00005 \
    --weight_decay 0.00001
