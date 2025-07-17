#!/bin/bash
#FLUX: --job-name=SS_FT_moco
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=booster
#FLUX: -t=57600
#FLUX: --urgency=16

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
srun python -u linear_SS_moco.py \
--data_dir /p/scratch/hai_ssl4eo/data/so2sat-lcz42 \
--bands B13 \
--checkpoints_dir /p/project/hai_ssl4eo/nassim/ssl-sentinel/src/benchmark/fullset_temp/checkpoints/moco_ft/SS_rn50_100_lr3 \
--backbone resnet50 \
--train_frac 1.0 \
--batchsize 64 \
--lr 0.01 \
--schedule 60 80 \
--epochs 100 \
--num_workers 10 \
--seed 42 \
--dist_url $dist_url \
--pretrained /p/project/hai_ssl4eo/wang_yi/ssl4eo-s12-dataset/src/benchmark/fullset_temp/checkpoints/moco/B13_rn50/checkpoint_0099.pth.tar \
--in_size 224 \
