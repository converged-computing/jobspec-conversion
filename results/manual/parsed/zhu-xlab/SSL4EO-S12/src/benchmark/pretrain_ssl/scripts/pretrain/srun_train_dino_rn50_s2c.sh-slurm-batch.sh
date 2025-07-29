#!/bin/bash
#FLUX: --job-name=pretrain_dino_rn50
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=booster
#FLUX: -t=86400
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
srun python -u pretrain_dino_s2c.py \
--is_slurm_job \
--data /p/scratch/hai_ssl4eo/data/ssl4eo_s12/ssl4eo_250k_s2c_uint8.lmdb \
--checkpoints_dir /p/project/hai_ssl4eo/wang_yi/ssl4eo-s12-dataset/src/benchmark/fullset_temp/checkpoints/dino/B13_rn50_224 \
--bands B13 \
--lmdb \
--arch resnet50 \
--num_workers 10 \
--batch_size_per_gpu 64 \
--epochs 100 \
--warmup_epochs 10 \
--lr 0.03 \
--optimizer sgd \
--weight_decay 1e-4 \
--weight_decay_end 1e-4 \
--global_crops_scale 0.14 1 \
--local_crops_scale 0.05 0.14 \
--dist_url $dist_url \
--seed 42 \
--mode s2c \
--dtype uint8 \
--season augment \
--in_size 224 \
