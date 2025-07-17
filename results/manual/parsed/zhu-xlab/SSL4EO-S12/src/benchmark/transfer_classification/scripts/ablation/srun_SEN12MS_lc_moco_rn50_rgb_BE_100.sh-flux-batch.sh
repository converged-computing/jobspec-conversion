#!/bin/bash
#FLUX: --job-name=BE_LC_moco
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=booster
#FLUX: -t=14400
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export CUDA_VISIBLE_DEVICES='0,1,2,3'

master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
module load Stages/2022
module load GCCcore/.11.2.0
module load Python
source /p/project/hai_dm4eo/wang_yi/env2/bin/activate
export CUDA_VISIBLE_DEVICES=0,1,2,3
srun python -u linear_BE_moco.py \
--lmdb_dir /p/project/hai_dm4eo/wang_yi/data/BigEarthNet/ \
--bands RGB \
--checkpoints_dir /p/project/hai_ssl4eo/wang_yi/SSL4EO-S12/src/benchmark/transfer_classification/checkpoints/SEN12MS_BE_lc_B3_moco_rn50_100 \
--backbone resnet50 \
--train_frac 1 \
--batchsize 256 \
--lr 8.0 \
--schedule 20 40 \
--epochs 50 \
--num_workers 10 \
--seed 42 \
--dist_url $dist_url \
--linear \
--pretrained /p/project/hai_ssl4eo/wang_yi/SSL4EO-S12/src/benchmark/pretrain_ssl/checkpoints/moco/SEN12MS_B3_rn50_224/checkpoint_0099.pth.tar \
