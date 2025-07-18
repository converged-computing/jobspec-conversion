#!/bin/bash
#FLUX: --job-name=sup_train
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --queue=booster
#FLUX: -t=14400
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
srun python -u so2sat_B10_resnet_train.py \
--data_dir /p/project/hai_dm4eo/wang_yi/data/so2sat-lcz42/ \
--bands B10 \
--checkpoints_dir /p/project/hai_dm4eo/wang_yi/ssl4eo-review/src/checkpoints/so2sat/sup/B10_rn18_100_tmp \
--backbone resnet18 \
--train_frac 1.0 \
--batchsize 256 \
--lr 0.2 \
--schedule 60 80 \
--epochs 100 \
--num_workers 8 \
--seed 42 \
--dist_url $dist_url \
