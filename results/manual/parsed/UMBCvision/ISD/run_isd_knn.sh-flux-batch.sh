#!/bin/bash
#FLUX: --job-name=knn_isd_3
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --priority=16

set -x
set -e
for exp_dir in output/isd_3_*_resnet18
do
    python eval_knn.py \
        -j 16 \
        -b 256 \
        --arch resnet18 \
        --weights $exp_dir/ckpt_epoch_200.pth \
        --save $exp_dir \
        /nfs/ada/hpirsiav/datasets/imagenet
done
