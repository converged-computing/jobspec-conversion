#!/bin/bash
#FLUX: --job-name=chocolate-nalgas-9548
#FLUX: --priority=16

python run_retrieval.py \
    --mode symmetric  \
    --dataset_path "$1" \
    --image_encoder resnet_18 \
    --text_encoder bert \
    --embedding_size 256 \
    --train_size 0.5 \
    --val_size 0.5 \
    --random_subset true \
    --checkpoint "asdf"
