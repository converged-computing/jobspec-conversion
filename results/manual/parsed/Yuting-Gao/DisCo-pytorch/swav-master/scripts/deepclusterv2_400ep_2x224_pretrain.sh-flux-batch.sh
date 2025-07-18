#!/bin/bash
#FLUX: --job-name=deepclusterv2_400ep_2x224_pretrain
#FLUX: -N=8
#FLUX: -c=8
#FLUX: -t=90000
#FLUX: --urgency=16

master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
DATASET_PATH="/path/to/imagenet/train"
EXPERIMENT_PATH="./experiments/deepclusterv2_400ep_2x224_pretrain"
mkdir -p $EXPERIMENT_PATH
srun --output=${EXPERIMENT_PATH}/%j.out --error=${EXPERIMENT_PATH}/%j.err --label python -u main_deepclusterv2.py \
--data_path $DATASET_PATH \
--nmb_crops 2 \
--size_crops 224 \
--min_scale_crops 0.08 \
--max_scale_crops 1. \
--crops_for_assign 0 1 \
--use_pil_blur false \
--temperature 0.1 \
--feat_dim 128 \
--nmb_prototypes 3000 3000 3000 \
--epochs 400 \
--batch_size 64 \
--base_lr 4.8 \
--final_lr 0.0048 \
--freeze_prototypes_niters 300000 \
--wd 0.000001 \
--warmup_epochs 10 \
--start_warmup 0.3 \
--dist_url $dist_url \
--arch resnet50 \
--sync_bn apex \
--dump_path $EXPERIMENT_PATH
