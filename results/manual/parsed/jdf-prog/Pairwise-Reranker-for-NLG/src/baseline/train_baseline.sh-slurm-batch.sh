#!/bin/bash
#FLUX: --job-name=train_baseline
#FLUX: -t=43200
#FLUX: --urgency=16

nvidia-smi
localhost=$RANDOM
torchrun \
    --rdzv_backend=c10d \
    --rdzv_endpoint="localhost:${localhost}" \
    --nnodes 1 \
    --nproc_per_node 1 \
train_baseline.py \
    --dataset cnndm \
    --model_type bart \
    --model facebook/bart-large \
    --model_name bart_cnndm_2_half \
    --evaluate_before_training False \
    --source_max_length 512 \
    --target_max_length 128 \
    --fp16 True \
    --per_device_train_batch_size 10 \
    --per_device_eval_batch_size 32 \
    --gradient_accumulation_steps 8 \
    --learning_rate 3e-5 \
    --generation_num_beams 5 \
    --num_train_epochs 10 \
