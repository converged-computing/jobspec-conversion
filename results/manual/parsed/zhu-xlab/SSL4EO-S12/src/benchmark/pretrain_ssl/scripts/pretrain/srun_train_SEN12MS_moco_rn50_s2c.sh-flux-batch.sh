#!/bin/bash
#FLUX: --job-name=pretrain_moco_rn50
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=booster
#FLUX: -t=72000
#FLUX: --urgency=16

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
srun python -u pretrain_moco_v2_sen12ms_ms.py \
--is_slurm_job \
--data /p/project/hai_ssl4eo/wang_yi/data/SEN12MS/SEN12MS_s2c_uint8.lmdb \
--checkpoints /p/project/hai_ssl4eo/wang_yi/SSL4EO-S12/src/benchmark/pretrain_ssl/checkpoints/moco/SEN12MS_B13_rn50_224 \
--bands B13 \
--lmdb \
--arch resnet50 \
--workers 8 \
--batch-size 64 \
--epochs 100 \
--lr 0.03 \
--mlp \
--moco-t 0.2 \
--aug-plus \
--cos \
--dist-url $dist_url \
--dist-backend 'nccl' \
--seed 42 \
--mode s2c \
--dtype uint8 \
--season augment \
--in_size 224 \
--resume /p/project/hai_ssl4eo/wang_yi/SSL4EO-S12/src/benchmark/pretrain_ssl/checkpoints/moco/SEN12MS_B13_rn50_224/checkpoint_0029.pth.tar
