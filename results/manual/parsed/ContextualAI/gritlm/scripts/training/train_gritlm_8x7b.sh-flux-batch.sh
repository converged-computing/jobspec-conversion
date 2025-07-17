#!/bin/bash
#FLUX: --job-name=gritlm
#FLUX: -N=32
#FLUX: --exclusive
#FLUX: --queue=a3
#FLUX: -t=3596400
#FLUX: --urgency=16

export WANDB_PROJECT='gritlm'
export CMD=' \'

cd /home/niklas/gritlm/gritlm
source /env/bin/start-ctx-user
conda activate gritlm
export WANDB_PROJECT="gritlm"
GPUS_PER_NODE=8
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
NNODES=$SLURM_NNODES
NODE_RANK=$SLURM_PROCID 
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
head_node_ip=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
LAUNCHER="accelerate launch \
    --config_file /home/niklas/gritlm/scripts/configs/confnew/config_256gpusfsdp_m8x7.yml \
    --num_machines $NNODES \
    --num_processes $WORLD_SIZE \
    --main_process_ip "$MASTER_ADDR" \
    --main_process_port $MASTER_PORT \
    --num_processes $WORLD_SIZE \
    --machine_rank \$SLURM_PROCID \
    --role $SLURMD_NODENAME: \
    --rdzv_conf rdzv_backend=c10d \
    --max_restarts 0 \
    --tee 3 \
    "
export CMD=" \
    -m training.run \
    --output_dir /data/niklas/gritlm/gritlm_m8x7_bs256_1253_token03 \
    --model_name_or_path mistralai/Mixtral-8x7B-v0.1 \
    --tokenizer_name mistralai/Mistral-7B-v0.1 \
    --train_data /data/niklas/gritlm/e5ds \
    --learning_rate 2e-5 \
    --lr_scheduler_type linear \
    --warmup_ratio 0.03 \
    --max_steps 1253 \
    --per_device_train_batch_size 1 \
    --gradient_accumulation_steps 1 \
    --dataloader_drop_last \
    --normalized \
    --temperature 0.02 \
    --train_group_size 2 \
    --negatives_cross_device \
    --query_max_len 256 \
    --passage_max_len 2048 \
    --mode unified \
    --logging_steps 1 \
    --bf16 \
    --pooling_method mean \
    --use_unique_indices \
    --loss_gen_factor 0.003 \
    --loss_gen_type token \
    --attn bbcc \
    --attn_implementation sdpa \
    --no_gen_gas \
    --no_emb_gas \
    --split_emb \
    --save_steps 5000 \
    --gradient_checkpointing
    "
SRUN_ARGS=" \
    --wait=6000 \
    --kill-on-bad-exit=1 \
    "
clear; srun $SRUN_ARGS --jobid $SLURM_JOB_ID bash -c "$LAUNCHER $CMD" 2>&1
