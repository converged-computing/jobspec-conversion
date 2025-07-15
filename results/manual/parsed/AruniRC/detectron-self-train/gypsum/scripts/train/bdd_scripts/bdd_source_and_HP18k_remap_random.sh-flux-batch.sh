#!/bin/bash
#FLUX: --job-name=bdd_source_and_HP18k_remap_random
#FLUX: --priority=16

python tools/train_net_step.py \
    --dataset bdd_peds+HP18k_remap_random \
    --cfg configs/baselines/bdd_distill100.yaml \
    --set NUM_GPUS 1 TRAIN.SNAPSHOT_ITERS 5000 \
    --iter_size 2 \
    --use_tfboard \
    --load_ckpt /mnt/nfs/scratch1/pchakrabarty/bdd_recs/bdd_baseline_clear_any_daytime/ckpt/model_step69999.pth \
    #--load_ckpt /mnt/nfs/work1/elm/arunirc/Research/detectron-video/detectron_distill/Detectron-pytorch-video/Outputs/e2e_faster_rcnn_R-50-C4_1x/Jul30-15-51-27_node097_step/ckpt/model_step79999.pth \
    #--load_ckpt Outputs/cityscapes/baseline_bdd_clear_any_daytime/ckpt/model_step69999.pth \
    #--load_ckpt Outputs/e2e_faster_rcnn_R-50-C4_1x/Jul30-15-51-27_node097_step/ckpt/model_step79999.pth \
