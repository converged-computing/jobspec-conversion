#!/bin/bash
#FLUX: --job-name=dh_hssn
#FLUX: --urgency=16

CONFIG=configs/deeplabv3plus/deeplabv3plus_r101-d8_480x480_60k_pascal_person_part_hiera_triplet.py
GPUS=1
PORT=7654
CUDA_VISIBLE_DEVICES=3 python -m torch.distributed.launch --nproc_per_node=$GPUS --master_port=$PORT \
    tools/train.py $CONFIG --launcher pytorch ${@:3}
