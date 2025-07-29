#!/bin/bash
#FLUX: --job-name=BE_LC_IN
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=booster
#FLUX: -t=7200
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
srun python -u linear_BE_sup.py \
--lmdb_dir /p/project/hai_dm4eo/wang_yi/data/BigEarthNet/ \
--bands B12 \
--checkpoints_dir /p/project/hai_ssl4eo/wang_yi/SSL4EO-S12/src/benchmark/transfer_classification/checkpoints/ImageNet_BE_lc_B12_sup_reinit_rn50_10 \
--backbone resnet50 \
--train_frac 0.1 \
--batchsize 256 \
--lr 8.0 \
--schedule 20 40 \
--epochs 50 \
--num_workers 10 \
--seed 42 \
--dist_url $dist_url \
--linear \
--pretrained /p/project/hai_ssl4eo/wang_yi/pretrained_weights/rn50_B3_sup_imagenet_600ep.pth \
--pretrain_style reinit \
