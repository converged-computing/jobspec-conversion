#!/bin/bash
#FLUX: --job-name=codellama_llamax_finetune
#FLUX: -c=10
#FLUX: --queue=a100
#FLUX: --urgency=16

export NCCL_IB_HCA='mlx5'
export NCCL_IB_TC='136'
export NCCL_IB_SL='5'
export NCCL_IB_GID_INDEX='3'
export NCCL_SOCKET_IFNAME='bond0'
export NCCL_DEBUG='INFO'
export HF_HOME='/cpfs/29cd2992fe666f2a/user/huangwenhao/alex/.cache/huggingface'
export WANDB_DISABLED='True'

export NCCL_IB_HCA=mlx5
export NCCL_IB_TC=136
export NCCL_IB_SL=5
export NCCL_IB_GID_INDEX=3
export NCCL_SOCKET_IFNAME=bond0
export NCCL_DEBUG=INFO
__conda_setup="$('/cpfs/29cd2992fe666f2a/user/huangwenhao/alex/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/cpfs/29cd2992fe666f2a/user/huangwenhao/alex/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/cpfs/29cd2992fe666f2a/user/huangwenhao/alex/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/cpfs/29cd2992fe666f2a/user/huangwenhao/alex/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
which conda
export HF_HOME=/cpfs/29cd2992fe666f2a/user/huangwenhao/alex/.cache/huggingface
cd /cpfs/29cd2992fe666f2a/user/huangwenhao/alex/uskg_eval/Llama-X/src
conda activate SKGLM
export WANDB_DISABLED=True
MODEL_DIR=/cpfs/29cd2992fe666f2a/user/huangwenhao/alex/codellama/CodeLlama-7b-Instruct-hf
DATA_PATH=/cpfs/29cd2992fe666f2a/user/huangwenhao/alex/uskg_eval/llama_data_v11_kg.json
OUTPUT_DIR=/cpfs/29cd2992fe666f2a/user/huangwenhao/alex/uskg_eval/models/llama/v11_kg
LAUNCHER="torchrun"
LAUNCHER_ARGS=(--master_addr=${MASTER_ADDR} \
    --master_port=${MASTER_PORT} \
    --nnodes=${WORLD_SIZE} \
    --node_rank=${RANK} \
    --nproc_per_node=${KUBERNETES_CONTAINER_RESOURCE_GPU} \
)
SCRIPT="train_on_formatted.py"
SCRIPT_ARGS=(--model_name_or_path ${MODEL_DIR} \
    --data_path "${DATA_PATH}" \
    --output_dir ${OUTPUT_DIR} \
    --pkl_path "cl_2048_v11_formatted.pkl" \
    --has_instruction True \
    --dataset_type="skg" \
    --num_train_epochs 3 \
    --model_max_length 2048 \
    --per_device_train_batch_size 16 \
    --per_device_eval_batch_size 1 \
    --gradient_accumulation_steps 2 \
    --evaluation_strategy no \
    --save_total_limit 3 \
    --save_strategy "epoch" \
    --learning_rate 2e-5 \
    --warmup_ratio 0.01 \
    --logging_steps 2 \
    --lr_scheduler_type cosine \
    --report_to "tensorboard" \
    --gradient_checkpointing True \
    --deepspeed configs/deepspeed_config_transformers4.31.json \
    --fp16 True
)
echo 'address:'${MASTER_ADDR},'SURM_JOBID:'${SLURM_PROCID}
echo $LAUNCHER "${LAUNCHER_ARGS[@]}" $SCRIPT "${SCRIPT_ARGS[@]}"
$LAUNCHER "${LAUNCHER_ARGS[@]}" $SCRIPT "${SCRIPT_ARGS[@]}"
