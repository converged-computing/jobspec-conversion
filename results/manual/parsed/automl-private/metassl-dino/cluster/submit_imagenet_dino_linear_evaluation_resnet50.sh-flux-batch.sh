#!/bin/bash
#FLUX: --job-name=IN_EVAL_DINO_RESNET50
#FLUX: --queue=alldlc_gpu-rtx2080
#FLUX: -t=86399
#FLUX: --urgency=16

pip list
source activate dino
python -m torch.distributed.launch --nproc_per_node=8 eval_linear.py --arch resnet50 --data_path /data/datasets/ImageNet/imagenet-pytorch --output_dir /work/dlclarge2/wagnerd-metassl-experiments/dino/ImageNet/$EXPERIMENT_NAME --batch_size_per_gpu 32 --pretrained_weights /work/dlclarge2/wagnerd-metassl-experiments/dino/ImageNet/$EXPERIMENT_NAME/checkpoint.pth --seed $SEED
