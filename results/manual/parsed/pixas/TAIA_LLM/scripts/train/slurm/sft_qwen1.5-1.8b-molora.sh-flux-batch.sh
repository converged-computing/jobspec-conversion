#!/bin/bash
#FLUX: --job-name=sft_qwen
#FLUX: -c=16
#FLUX: --queue=partition
#FLUX: -t=259200
#FLUX: --urgency=16

export LOGLEVEL='INFO'
export NCCL_DEBUG='ERROR'

nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun -N1 -n1 -w "$head_node" hostname --ip-address)
GPUS_PER_NODE=1
NNODES=$SLURM_NNODES
echo Node IP: $head_node_ip nodes_array: $nodes_array
srun bash -c 'echo $SLURMD_NODENAME-$SLURM_JOB_GPUS' # 打印出不同机器上分配的显卡编号
export LOGLEVEL=INFO
MASTER_ADDR=`scontrol show hostname $SLURM_JOB_NODELIST | head -n1`
MASTER_PORT=$((RANDOM % 101 + 20000))
echo $MASTER_PORT
export NCCL_DEBUG=ERROR
CHECKPOINT_DIR=<test> # replace this as your actual checkpoint name
OUTPUT_DIR=<checkpoint>/${CHECKPOINT_DIR} # replace the checkpoint as your own checkpoint folder
MODEL_PATH=<Qwen1.5-1.8b-chat-path> # replace the model path as your own model path
TRAIN_DATA_PATH=datas/train/alpaca_gpt4_bilingual.json
srun --jobid $SLURM_JOBID python -u -m torch.distributed.run \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --rdzv_id $MASTER_PORT --rdzv_backend c10d --rdzv_endpoint $head_node_ip:$MASTER_PORT \
    --rdzv_backend c10d \
    --node_rank $SLURM_PROCID \
    ming/train/train_mem.py \
    --lora_enable --lora_r 16 --lora_alpha 32 \
    --num_experts 4 --num_experts_per_token 1 --expert_selection "topk" \
    --deepspeed scripts/zero3.json \
    --model_name_or_path $MODEL_PATH \
    --train_data_path $TRAIN_DATA_PATH \
    --bf16 True \
    --output_dir $OUTPUT_DIR \
    --num_train_epochs 1 \
    --per_device_train_batch_size 1 \
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 4 \
    --evaluation_strategy "no" \
    --save_strategy "steps" \
    --save_steps 100 \
    --save_total_limit 1 \
    --learning_rate 2e-4 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --tf32 True \
    --model_max_length 3072 \
    --gradient_checkpointing True \
    --dataloader_num_workers 6 \
    --lazy_preprocess True \
    --report_to wandb
