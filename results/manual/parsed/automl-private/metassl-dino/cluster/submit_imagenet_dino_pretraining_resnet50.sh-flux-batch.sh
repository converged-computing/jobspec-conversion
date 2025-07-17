#!/bin/bash
#FLUX: --job-name=IN_PT_DINO_RESNET50
#FLUX: --queue=mldlc_gpu-rtx2080
#FLUX: -t=345599
#FLUX: --urgency=16

pip list
source activate dino
python -u -m torch.distributed.launch --use_env --nproc_per_node=8 --nnodes 1 main_dino.py --arch resnet50 --data_path /data/datasets/ImageNet/imagenet-pytorch/train --output_dir /work/dlclarge2/wagnerd-metassl-experiments/dino/ImageNet/$EXPERIMENT_NAME --batch_size_per_gpu 32 --saveckp_freq 10 --seed $SEED
