#!/bin/bash
#FLUX: --job-name=BE_LC_mae_vits16
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=booster
#FLUX: -t=36000
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
srun python -u linear_BE_mae.py \
--is_slurm_job \
--data_path /p/scratch/hai_ssl4eo/data/bigearthnet/BigEarthNet_LMDB_uint8 \
--output_dir /p/project/hai_ssl4eo/wang_yi/ssl4eo-s12-dataset/src/benchmark/fullset_temp/checkpoints/mae_lc/BE_vits16_100 \
--log_dir /p/project/hai_ssl4eo/wang_yi/ssl4eo-s12-dataset/src/benchmark/fullset_temp/checkpoints/mae_lc/BE_vits16_100/log \
--model vit_small_patch16 \
--nb_classes 19 \
--train_frac 1.0 \
--num_workers 10 \
--batch_size 64 \
--epochs 100 \
--lr 1.0 \
--warmup_epochs 0 \
--dist_url $dist_url \
--dist_backend 'nccl' \
--seed 42 \
--finetune /p/project/hai_ssl4eo/wang_yi/ssl4eo-s12-dataset/src/benchmark/fullset_temp/checkpoints/mae/B13_vits16_70/checkpoint-99.pth
