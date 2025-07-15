#!/bin/bash
#FLUX: --job-name=moco_bigearthnet
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --queue=booster
#FLUX: -t=36000
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'

master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
module load GCCcore/.9.3.0
module load Python
module load torchvision
module load OpenCV
module load scikit
module load TensorFlow
source /p/project/hai_dm4eo/wang_yi/env1/bin/activate
export CUDA_VISIBLE_DEVICES=0,1,2,3
srun python -u bigearthnet_B12_moco_train.py \
--data /p/project/hai_dm4eo/wang_yi/data/BigEarthNet \
--checkpoints /p/project/hai_dm4eo/wang_yi/ssl4eo-review/src/checkpoints/moco/B12_rn18_no_crop \
--bands all \
--lmdb \
--arch resnet18 \
--workers 8 \
--batch-size 64 \
--epochs 100 \
--lr 0.05 \
--mlp \
--moco-t 0.2 \
--aug-plus \
--schedule 60 80 \
--cos \
--dist-url $dist_url \
--dist-backend 'nccl' \
--seed 42 \
