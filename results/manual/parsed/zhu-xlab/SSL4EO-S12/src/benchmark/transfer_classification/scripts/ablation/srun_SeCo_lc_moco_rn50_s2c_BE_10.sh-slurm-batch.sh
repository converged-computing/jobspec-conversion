#!/bin/bash
#FLUX: --job-name=BE_LC_moco
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=booster
#FLUX: -t=3600
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
--bands B12 \
--checkpoints_dir /p/project/hai_ssl4eo/wang_yi/SSL4EO-S12/src/benchmark/transfer_classification/checkpoints/SeCo_BE_lc_B12_moco_rn50_10 \
--backbone resnet50 \
--train_frac 0.1 \
--batchsize 256 \
--lr 0.1 \
--schedule 20 40 \
--epochs 50 \
--num_workers 10 \
--seed 42 \
--dist_url $dist_url \
--linear \
--pretrained /p/project/hai_ssl4eo/wang_yi/SSL4EO-S12/src/benchmark/pretrain_ssl/checkpoints/moco/SeCo_B12_rn50_224/checkpoint_0099.pth.tar \
