#!/bin/bash
#FLUX: --job-name=llama_finetune
#FLUX: --queue=a100
#FLUX: -t=86400
#FLUX: --urgency=16

export NCCL_IB_DISABLE='1;'
export NCCL_P2P_DISABLE='1;'
export NCCL_DEBUG='INFO;'
export NCCL_SOCKET_IFNAME='en,eth,em,bond;'
export CXX='g++;'

nvidia-smi
MASTER_PORT=4637
MODEL_DIR="meta-llama/Llama-2-7b-hf" # 13b
run_name="llama.train_mix.check.clean.mathQA" # change this every time you run a new experiment
output_dir="../../outputs/${MODEL_DIR}/${run_name}"
train_data_path="../../data/train_mix.check.clean.mathQA.format_v2.json" # 
mkdir -p ${output_dir}
export NCCL_IB_DISABLE=1;
export NCCL_P2P_DISABLE=1;
export NCCL_DEBUG=INFO;
export NCCL_SOCKET_IFNAME=en,eth,em,bond;
export CXX=g++;
CUDA_VISIBLE_DEVICES=0,1,2,3 deepspeed \
    --num_gpus 4 \
    --num_nodes 1 \
    --master_port ${MASTER_PORT} \
    train.py \
    --model_name_or_path ${MODEL_DIR} \
    --train_data_path ${train_data_path} \
    --bf16 True \
    --output_dir ${output_dir} \
    --num_train_epochs 3 \
    --per_device_train_batch_size 1 \
    --per_device_eval_batch_size 2 \
    --gradient_accumulation_steps 32 \
    --model_max_length 1024 \
    --evaluation_strategy "no" \
    --save_strategy "epoch" \
    --save_steps 64 \
    --save_total_limit 6 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.1 \
    --lr_scheduler_type "cosine" \
    --logging_steps 2 \
    --tf32 True \
    --deepspeed ds_llama_config.json \
    --run_name ${run_name} \
    --seed 42 \
    --is_lora False \
