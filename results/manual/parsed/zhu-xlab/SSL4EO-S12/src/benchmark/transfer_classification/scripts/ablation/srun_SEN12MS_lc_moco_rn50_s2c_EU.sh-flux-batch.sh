#!/bin/bash
#FLUX: --job-name=EU_lc_moco
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=develbooster
#FLUX: -t=3600
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export CUDA_VISIBLE_DEVICES='0,1,2,3'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
module load Stages/2022
module load GCCcore/.11.2.0
module load Python
source /p/project/hai_dm4eo/wang_yi/env2/bin/activate
export CUDA_VISIBLE_DEVICES=0,1,2,3
srun python -u linear_EU_moco.py \
--data_dir /p/project/hai_dm4eo/wang_yi/data/eurosat/tif/ \
--bands B13 \
--checkpoints_dir /p/project/hai_ssl4eo/wang_yi/SSL4EO-S12/src/benchmark/transfer_classification/checkpoints/SEN12MS_EU_lc_B13_moco_rn50 \
--backbone resnet50 \
--train_frac 1.0 \
--batchsize 64 \
--lr 0.1 \
--schedule 20 40 \
--epochs 50 \
--num_workers 10 \
--seed 42 \
--dist_url $dist_url \
--pretrained /p/project/hai_ssl4eo/wang_yi/SSL4EO-S12/src/benchmark/pretrain_ssl/checkpoints/moco/SEN12MS_B13_rn50_224/checkpoint_0099.pth.tar \
--in_size 224 \
