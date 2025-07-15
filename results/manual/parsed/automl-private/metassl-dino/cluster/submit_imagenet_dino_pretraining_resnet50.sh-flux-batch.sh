#!/bin/bash
#FLUX: --job-name=dirty-bits-1258
#FLUX: --priority=16

pip list
source activate dino
python -u -m torch.distributed.launch --use_env --nproc_per_node=8 --nnodes 1 main_dino.py --arch resnet50 --data_path /data/datasets/ImageNet/imagenet-pytorch/train --output_dir /work/dlclarge2/wagnerd-metassl-experiments/dino/ImageNet/$EXPERIMENT_NAME --batch_size_per_gpu 32 --saveckp_freq 10 --seed $SEED
