#!/bin/bash
#FLUX: --job-name=phat-hobbit-6279
#FLUX: --urgency=16

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
