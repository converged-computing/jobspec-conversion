#!/bin/bash
#FLUX: --job-name=da-cst-im-roi_cs6-HP-WIDER
#FLUX: --priority=16

python tools/train_net_step.py \
    --dataset bdd_peds+HP18k \
    --cfg configs/baselines/bdd_DA_and_distill.yaml \
    --set NUM_GPUS 1 TRAIN.SNAPSHOT_ITERS 1000 \
    --iter_size 2 \
    --use_tfboard \
    #--load_ckpt /mnt/nfs/work1/elm/arunirc/Research/detectron-video/detectron_distill/Detectron-pytorch-video/Outputs/e2e_faster_rcnn_R-50-C4_1x/Jul30-15-51-27_node097_step/ckpt/model_step79999.pth \
