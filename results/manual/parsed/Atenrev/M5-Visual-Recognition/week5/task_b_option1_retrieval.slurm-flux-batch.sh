#!/bin/bash
#FLUX: --job-name=misunderstood-latke-5845
#FLUX: --urgency=16

python run_retrieval.py \
    --mode text_to_image  \
    --dataset_path "$1" \
    --image_encoder resnet_18 \
    --text_encoder clip \
    --embedding_size 256 \
    --train_size 0.5 \
    --val_size 0.5 \
    --random_subset true \
    --checkpoint "asdf"
