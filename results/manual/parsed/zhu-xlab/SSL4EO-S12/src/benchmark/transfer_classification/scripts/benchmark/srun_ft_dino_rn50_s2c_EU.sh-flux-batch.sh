#!/bin/bash
#FLUX: --job-name=EU_LC_dino
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=develbooster
#FLUX: -t=3600
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'

master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
module load Stages/2022
module load GCCcore/.11.2.0
module load Python
source /p/project/hai_dm4eo/wang_yi/env2/bin/activate
export CUDA_VISIBLE_DEVICES=0,1,2,3
srun python -u finetune_EU_dino.py \
--data_dir /p/scratch/hai_ssl4eo/data/eurosat/tif \
--bands B13 \
--checkpoints_dir /p/project/hai_ssl4eo/nassim/ssl-sentinel/src/benchmark/fullset_temp/checkpoints//dino_ft/EU_rn50_lr3 \
--arch resnet50 \
--train_frac 1.0 \
--batch_size_per_gpu 64 \
--lr 0.001 \
--epochs 100 \
--num_workers 10 \
--seed 42 \
--dist_url $dist_url \
--pretrained /p/project/hai_ssl4eo/wang_yi/ssl4eo-s12-dataset/src/benchmark/fullset_temp/checkpoints/dino/B13_rn50_224/checkpoint.pth \
