#!/bin/bash
#FLUX: --job-name=nerdy-earthworm-9390
#FLUX: --priority=16

source /home/ferreira/.profile
source activate dino
python -m main_dino --arch vit_small --data_path /data/datasets/ImageNet/imagenet-pytorch/train --output_dir /work/dlclarge2/ferreira-dino/metassl-dino/experiments/dino/$EXPERIMENT_NAME --batch_size_per_gpu 40 --is_neps_run --epochs 100 --world_size 8 --gpu 8
