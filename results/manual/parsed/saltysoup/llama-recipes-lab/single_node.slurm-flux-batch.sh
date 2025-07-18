#!/bin/bash
#FLUX: --job-name=strawberry-hippo-1069
#FLUX: --queue=l4train
#FLUX: -t=3600
#FLUX: --urgency=16

export MASTER_ADDR='$head_node_ip'
export MASTER_PORT='$head_node_port'
export MODEL_NAME='meta-llama/Llama-2-7b-chat-hf'
export MODEL_NAME_NEW='${MODEL_NAME}_new'
export MODEL_OUTPUT_DIR='/bucket/model/${MODEL_NAME_NEW}'
export MODEL_CHECKPOINT_ROOT_DIR='/bucket/checkpoints'
export MODEL_CHECKPOINT_FOLDER='$MODEL_NAME_NEW'
export PYTHONFAULTHANDLER='1'
export CUDA_LAUNCH_BLOCKING='0'
export LOGLEVEL='INFO'

echo "setting HF token to download base model"
HUGGINGFACE_TOKEN="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"
huggingface-cli login --token $HUGGINGFACE_TOKEN
echo "NODELIST="${SLURM_NODELIST}
head_node_ip=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
head_node_port=29500
export MASTER_ADDR=$head_node_ip
export MASTER_PORT=$head_node_port
export MODEL_NAME="meta-llama/Llama-2-7b-chat-hf"
export MODEL_NAME_NEW="${MODEL_NAME}_new"
export MODEL_OUTPUT_DIR="/bucket/model/${MODEL_NAME_NEW}"
export MODEL_CHECKPOINT_ROOT_DIR="/bucket/checkpoints"
export MODEL_CHECKPOINT_FOLDER="$MODEL_NAME_NEW"
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0
export LOGLEVEL=INFO
echo "starting training now.. on ${SLURM_NNODES} nodes with ${SLURM_GPUS} GPUs each"
cd $SLURM_SUBMIT_DIR
srun torchrun --nnodes $SLURM_NNODES \
        --nproc_per_node $SLURM_GPUS \
        --rdzv-endpoint "$MASTER_ADDR:$MASTER_PORT" \
        --rdzv-id $SLURM_JOB_ID \
        --rdzv-backend c10d \
        --log_dir logs \
        examples/finetuning.py --enable_fsdp --fsdp_config.pure_bf16 --use_peft --peft_method lora --use_fast_kernels --model_name "$MODEL_NAME" --batch_size_training 1 --gradient_accumulation_steps 4 --num_epochs 2 --output_dir "${MODEL_CHECKPOINT_ROOT_DIR}/${MODEL_CHECKPOINT_FOLDER}" --dist_checkpoint_folder "$MODEL_CHECKPOINT_FOLDER"
