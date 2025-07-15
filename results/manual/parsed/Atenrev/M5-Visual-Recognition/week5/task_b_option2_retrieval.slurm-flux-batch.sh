#!/bin/bash
#FLUX: --job-name=chocolate-hobbit-3201
#FLUX: --urgency=16

python run_retrieval.py \
    --mode text_to_image  \
    --dataset_path "$1" \
    --image_encoder resnet_18 \
    --text_encoder bert \
    --embedding_size 256 \
    --train_size 0.5 \
    --val_size 0.5 \
    --random_subset true \
    --checkpoint "asdf"
