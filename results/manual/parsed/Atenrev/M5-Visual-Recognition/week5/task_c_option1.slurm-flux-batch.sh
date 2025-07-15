#!/bin/bash
#FLUX: --job-name=expressive-poo-3367
#FLUX: --priority=16

python task_a.py \
    --mode symmetric \
    --output_path "outputs_task_symmetric/" \
    --dataset_path "$1" \
    --train_size 0.6 \
    --val_size 1.0 \
    --random_subset True \
	--image_encoder resnet_18 \
    --text_encoder clip \
    --embedding_size 256 \
	--batch_size 64 \
    --epochs 15 \
    --lr 0.0001 \
    --weight_decay 0.0001
