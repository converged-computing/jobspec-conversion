#!/bin/bash
#FLUX: --job-name=scruptious-citrus-0909
#FLUX: --priority=16

module load gcc/gcc-10.2.0
module load nvidia/cuda-11.1 nvidia/cudnn-v8.1.1.33-forcuda11.0-to-11.2
source /home/pszzz/miniconda3/bin/activate zhy
CUDA_VISIBLE_DEVICES=0
MODEL_PATH='output_cosine/CD_food/RankStat/checkpoints/epoch-best.pth'
DATASET_NAME='CD_food'
python rs_results.py \
 --model_path $MODEL_PATH\
 --dataset $DATASET_NAME
