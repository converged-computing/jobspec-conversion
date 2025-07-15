#!/bin/bash
#FLUX: --job-name=B14_sup_rn50
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --queue=booster
#FLUX: -t=28800
#FLUX: --urgency=16

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
srun python -u sup_rn_B14.py \
--lmdb_dir /p/scratch/hai_dm4eo/wang_yi/BigEarthNet_LMDB \
--bands B14 \
--checkpoints_dir /p/project/hai_dm4eo/wang_yi/ssl4eo-s1s2/src/checkpoints/sup/B14_rn50_100 \
--backbone resnet50 \
--train_frac 1 \
--batchsize 64 \
--lr 0.001 \
--optimizer AdamW \
--epochs 100 \
--num_workers 8 \
--seed 42 \
--dist_url $dist_url \
--cos \
