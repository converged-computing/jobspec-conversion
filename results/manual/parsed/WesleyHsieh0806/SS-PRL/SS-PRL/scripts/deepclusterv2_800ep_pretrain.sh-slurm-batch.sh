#!/bin/bash
#FLUX: --job-name=deepclusterv2_800ep_pretrain
#FLUX: -N=8
#FLUX: -c=8
#FLUX: -t=144000
#FLUX: --urgency=16

master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
DATASET_PATH="/path/to/imagenet/train"
EXPERIMENT_PATH="./experiments/deepclusterv2_800ep_pretrain"
mkdir -p $EXPERIMENT_PATH
srun --output=${EXPERIMENT_PATH}/%j.out --error=${EXPERIMENT_PATH}/%j.err --label python -u main_deepclusterv2.py \
--data_path $DATASET_PATH \
--nmb_crops 2 6 \
--size_crops 224 96 \
--min_scale_crops 0.14 0.05 \
--max_scale_crops 1. 0.14 \
--crops_for_assign 0 1 \
--temperature 0.1 \
--feat_dim 128 \
--nmb_prototypes 3000 3000 3000 \
--epochs 800 \
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
