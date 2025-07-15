#!/bin/bash
#FLUX: --job-name=B13_sup_10
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --queue=booster
#FLUX: -t=3000
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
srun python -u eurosat_B13_resnet_train.py \
--data_dir /p/project/hai_dm4eo/wang_yi/data/eurosat/tif \
--bands B13 \
--checkpoints_dir /p/project/hai_dm4eo/wang_yi/ssl4eo-review/src/checkpoints/transfer_BE/sup/B13_sup_rn18_10 \
--save_path /p/project/hai_dm4eo/wang_yi/ssl4eo-review/src/checkpoints/transfer_BE/sup/B13_sup_rn18_10.pth.tar \
--backbone resnet18 \
--train_frac 0.1 \
--batchsize 16 \
--lr 0.1 \
--schedule 60 80 \
--epochs 100 \
--num_workers 8 \
--seed 42 \
--dist_url $dist_url \
