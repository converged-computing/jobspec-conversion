#!/bin/bash
#FLUX: --job-name=gloopy-lizard-7100
#FLUX: -t=42900
#FLUX: --urgency=16

export ARABIC_DATA='data/train'
export TASK_NAME='arabic_sentiment'

nvidia-smi
module purge
export ARABIC_DATA=data/train
export TASK_NAME=arabic_sentiment
python run_text_classification.py \
  --model_type bert \
  --model_name_or_path /scratch/nlp/CAMeLBERT/model/bert-base-wp-30k_msl-512-MSA-full-1000000-step \
  --task_name $TASK_NAME \
  --do_train \
  --do_eval \
  --eval_all_checkpoints \
  --save_steps 500 \
  --data_dir $ARABIC_DATA \
  --max_seq_length 128 \
  --per_gpu_train_batch_size 32 \
  --per_gpu_eval_batch_size 32 \
  --learning_rate 3e-5 \
  --num_train_epochs 3.0 \
  --overwrite_output_dir \
  --overwrite_cache \
  --output_dir /scratch/ba63/fine_tuned_models/sentiment_models/CAMeLBERT_MSA_arabic_sentiment/$TASK_NAME \
  --seed 12345
