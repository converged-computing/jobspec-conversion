#!/bin/bash
#FLUX: --job-name=salted-lentil-9947
#FLUX: --urgency=16

module load gcc/gcc-10.2.0
module load nvidia/cuda-11.1 nvidia/cudnn-v8.1.1.33-forcuda11.0-to-11.2
source /home/pszzz/miniconda3/bin/activate zhy
CUDA_VISIBLE_DEVICES=0 python train_herb.py \
 --dataset_name='herbarium_19' \
 --pseudo_ratio=0.6 \
 --lambda_loss=0.2 \
 --coteaching_epoch_t=30 \
 --coteaching_epoch_i=10 \
 --seed_num=1 \
 --interrupted_path='' \
 --batch_size=128 \
 --experiment_name='herbarium_19_pseduo0.6_lambda0.2_warm(30-10)_seed1'
