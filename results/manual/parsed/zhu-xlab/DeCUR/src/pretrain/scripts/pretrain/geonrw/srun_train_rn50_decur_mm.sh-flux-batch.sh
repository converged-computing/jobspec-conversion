#!/bin/bash
#FLUX: --job-name=lf2_bt_rn50
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=booster
#FLUX: -t=21600
#FLUX: --priority=16

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
srun python -u pretrain_mm.py \
--dataset GEONRW \
--mode RGB DSM \
--method DeCUR \
--data1 /p/project/hai_ssl4eo/wang_yi/data/nrw_dataset_250x250/img_dir/train \
--data2 /p/project/hai_ssl4eo/wang_yi/data/nrw_dataset_250x250/dem_dir/train \
--epochs 100 \
--batch-size 64 \
--workers 10 \
--learning-rate-weights 0.2 \
--learning-rate-biases 0.0048 \
--weight-decay 1e-6 \
--lambd 0.0051 \
--projector 8192-8192-8192 \
--print-freq 100 \
--checkpoint-dir /p/project/hai_dm4eo/wang_yi/ssl4eo-mm-v3/src/pretrain/checkpoints/geonrw/B3B1_lf2_bt_decu_rn50_prj8192 \
--backbone resnet50 \
--dist_url $dist_url \
--cos \
--dim_common 6144 \
