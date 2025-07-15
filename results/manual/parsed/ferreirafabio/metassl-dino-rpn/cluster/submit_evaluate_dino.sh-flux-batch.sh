#!/bin/bash
#FLUX: --job-name=salted-leopard-6600
#FLUX: --urgency=16

source /home/ferreira/.profile
source activate dino
pip show neps
python -m eval_linear.py --arch vit_small --data_path /data/datasets/ImageNet/imagenet-pytorch/train --output_dir /work/dlclarge2/ferreira-dino/metassl-dino/experiments/dino/dino_neps_11_05_2022_distributed_fix/config_8_2_linear_eval --batch_size_per_gpu 40 --epochs 100 --pretrained_weights /work/dlclarge2/ferreira-dino/metassl-dino/experiments/dino/dino_neps_11_05_2022_distributed_fix/config_8_2_linear_eval/checkpoint.pth
