#!/bin/bash
#FLUX: --job-name=isd_6_plus_tt_0x02_ts_0x20_cos_lr_0x01_m_0x99_aug_ws_mlp_resnet18
#FLUX: -c=24
#FLUX: --queue=gpu
#FLUX: -t=777600
#FLUX: --urgency=16

set -x
set -e
python train_isd_plus.py \
    --momentum 0.99 \
    --temp_t 0.02 \
    --temp_s 0.20 \
    --learning_rate 0.01 \
    --cos \
    --arch resnet18 \
    --augmentation 'weak/strong' \
    --checkpoint_path output/isd_6_plus_tt_0x02_ts_0x20_cos_lr_0x01_m_0x99_aug_ws_mlp_resnet18 \
    /nfs/ada/hpirsiav/datasets/imagenet
