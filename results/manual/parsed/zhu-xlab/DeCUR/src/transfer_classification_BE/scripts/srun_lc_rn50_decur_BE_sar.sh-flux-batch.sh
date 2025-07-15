#!/bin/bash
#FLUX: --job-name=BE_LC_s1
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=booster
#FLUX: -t=3600
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'
export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'

master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
module load Stages/2022
module load GCCcore/.11.2.0
module load Python
source /p/project/hai_dm4eo/wang_yi/env2/bin/activate
export CUDA_VISIBLE_DEVICES=0,1,2,3
export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
srun python -u linear_BE.py \
--lmdb_dir /p/project/hai_dm4eo/wang_yi/data/BigEarthNet/ \
--mode s1 \
--checkpoints_dir /p/project/hai_dm4eo/wang_yi/decur/src/transfer_classification/checkpoints/BE_s1_LC_rn50_decur_1 \
--backbone resnet50 \
--train_frac 0.01 \
--batchsize 64 \
--lr 0.5 \
--schedule 60 80 \
--epochs 100 \
--num_workers 10 \
--seed 42 \
--dist_url $dist_url \
--linear \
--pretrained /p/project/hai_dm4eo/wang_yi/decur/src/pretrain/checkpoints/late_fusion_2p2/B2B13_bt_decu_rn50_prj8192/checkpoint_0099.pth \
