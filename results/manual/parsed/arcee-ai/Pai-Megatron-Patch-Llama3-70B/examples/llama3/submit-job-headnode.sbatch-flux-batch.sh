#!/bin/bash
#FLUX: --job-name=megatron_gpt
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: --urgency=16

export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_DEBUG='INFO'
export CUDA_DEVICE_MAX_CONNECTIONS='1'
export WANDB_API_KEY='334c1fea66a31bc72bbfc9bb2244852031413811'
export PYTHONPATH='/workspace/Pai-Megatron-Patch-Llama3-70B/Megatron-LM:/workspace/Pai-Megatron-Patch-Llama3-70B:$PYTHONPATH'

set -ex;
: "${TENSOR_PARALLEL:=8}"
: "${PIPELINE_PARALLEL:=4}"
: "${NUM_LAYERS:=80}"
: "${HIDDEN_SIZE:=8192}"
: "${NUM_ATTENTION_HEADS:=64}"
: "${SEQ_LENGTH:=4096}"
: "${MAX_POSITION_EMBEDDINGS:=8192}"
: "${MICRO_BATCH_SIZE:=1}"
: "${GLOBAL_BATCH_SIZE:=128}"
: "${EXTRA_VOCAB_SIZE:=256}"
: "${IMAGE:=$(pwd)/megatron-pai-training.sqsh}"
: "${DATA_PATH:=/fsx}"
: "${FSX_MOUNT:=$(pwd):$DATA_PATH}"
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_DEBUG=INFO
export CUDA_DEVICE_MAX_CONNECTIONS=1
export WANDB_API_KEY="334c1fea66a31bc72bbfc9bb2244852031413811"
declare -a ARGS=(
    --container-image $IMAGE
    --container-mounts $FSX_MOUNT
)
declare -a TORCHRUN_ARGS=(
    # change this to match the number of gpus per node:
    --nproc_per_node=8
    --nnodes=$SLURM_JOB_NUM_NODES
    --rdzv_id=$SLURM_JOB_ID
    --rdzv_backend=c10d
    --rdzv_endpoint=$(hostname)
)
: "${TRAIN_TOKENS:=100000000}"
: "${WARMUP_TOKENS:=10000}"
: "${TRAIN_ITERS:=$(( ${TRAIN_TOKENS} / ${GLOBAL_BATCH_SIZE} / ${SEQ_LENGTH} ))}"
: "${LR_WARMUP_ITERS:=$(( ${WARMUP_TOKENS} / ${GLOBAL_BATCH_SIZE} / ${SEQ_LENGTH} ))}"
: "${LR_DECAY_ITERS:=$(( ${TRAIN_TOKENS} / ${GLOBAL_BATCH_SIZE} / ${SEQ_LENGTH} ))}"
declare -a MODEL_ARGS=(
        --use-mcore-models
        --disable-bias-linear
        --seq-length $SEQ_LENGTH
        --max-position-embeddings $MAX_POSITION_EMBEDDINGS
        --num-layers $NUM_LAYERS
        --hidden-size $HIDDEN_SIZE
        --ffn-hidden-size 28672
        --num-attention-heads $NUM_ATTENTION_HEADS
        --init-method-std 0.01
        --attention-dropout 0.0
        --hidden-dropout 0.0
        --normalization RMSNorm
        --norm-epsilon 1e-05 
        --position-embedding-type rope
        --rotary-base 500000
        --no-rope-fusion 
        --use-rotary-position-embeddings
        --swiglu
        --untie-embeddings-and-output-weights
        --group-query-attention
        --num-query-groups 8
        --no-masked-softmax-fusion
)
declare -a TRAINING_ARGS=(
        --micro-batch-size $MICRO_BATCH_SIZE
        --global-batch-size $GLOBAL_BATCH_SIZE
        --lr 1.0e-5
        --train-iters $TRAIN_ITERS
        --eval-iters 40 
        --eval-interval 10000 
        --lr-decay-iters $LR_DECAY_ITERS
        --lr-decay-style cosine
        --lr-warmup-iters $LR_WARMUP_ITERS
        --split 99,1,0 
        --min-lr 1.0e-6
        --weight-decay 0.1
        --adam-beta1 0.9
        --adam-beta2 0.95 
        --clip-grad 1.0
        --bf16
        --overlap-grad-reduce
        --overlap-param-gather
        --use-flash-attn
        # --make-vocab-size-divisible-by 64
)
declare -a MEGATRON_PARALLELISM=(
        --tensor-model-parallel-size $TENSOR_PARALLEL
        --pipeline-model-parallel-size $PIPELINE_PARALLEL
        --sequence-parallel
        --use-distributed-optimizer
)
declare -a CHECKPOINTING_ARGS=(
        --save "${DATA_PATH}/hyperpod_checkpoints" 
        --load "${DATA_PATH}/checkpoint-conversion/Llama3-70B-Checkpoint/Meta-Llama-3-70B-to-mcore-tp8-pp4" 
        --no-load-optim 
        --no-save-optim
        --no-load-rng 
        --no-save-rng
        --exit-on-missing-checkpoint
        --save-interval 7500
)
declare -a DATA_ARGS=(
        --data-path "${DATA_PATH}/llama3_data/SlimPajama_llamabpe_text_document" 
        --patch-tokenizer-type LLama3Tokenizer
        --extra-vocab-size $EXTRA_VOCAB_SIZE
        --dataset LLama-Pretrain-Idxmap 
)
declare -a LOGGING_ARGS=(
        --wandb-project ${WANDB_PROJECT:-"Hyperpod-Mixtral-Llama-70B"} 
        --wandb-exp-name ${WANDB_NAME:-"Llama-70B-Test-1"} 
        --tensorboard-dir "${DATA_PATH}/hyperpod_checkpoints/tensorboard-cpt" 
        --log-interval 1 
        --log-progress
)
AUTO_RESUME=""
if [ -d "/opt/sagemaker_cluster" ]; then
    echo "Detected Hyperpod cluster.. enabling --auto-resume=1"
    AUTO_RESUME="--auto-resume=1"
fi
export PYTHONPATH="/workspace/Pai-Megatron-Patch-Llama3-70B/Megatron-LM:/workspace/Pai-Megatron-Patch-Llama3-70B:$PYTHONPATH"
srun    ${AUTO_RESUME} -l "${ARGS[@]}" python -m torch.distributed.run "${TORCHRUN_ARGS[@]}" pretrain_llama.py \
        "${MEGATRON_PARALLELISM[@]}" \
        "${MODEL_ARGS[@]}" \
        "${TRAINING_ARGS[@]}" \
        "${DATA_ARGS[@]}" \
        "${CHECKPOINTING_ARGS[@]}" \
        "${LOGGING_ARGS[@]}"
