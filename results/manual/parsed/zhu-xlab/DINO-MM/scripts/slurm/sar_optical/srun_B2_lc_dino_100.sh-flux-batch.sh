#!/bin/bash
#FLUX: --job-name=b2_lc
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --queue=booster
#FLUX: -t=28800
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
srun python -u linear_dino_B2.py \
--data_path /p/scratch/hai_dm4eo/wang_yi/BigEarthNet_LMDB \
--output_dir /p/project/hai_dm4eo/wang_yi/ssl4eo-s1s2/src/checkpoints/dino_lc/B2_vit_s_8_crop_100 \
--lmdb \
--train_frac 1 \
--arch vit_small \
--patch_size 8 \
--num_workers 8 \
--batch_size_per_gpu 64 \
--epochs 100 \
--lr 0.01 \
--num_labels 19 \
--is_slurm_job \
--dist_url $dist_url \
--pretrained_weights /p/project/hai_dm4eo/wang_yi/ssl4eo-s1s2/src/checkpoints/dino/B2_vit_s_8_crop/checkpoint.pth \
