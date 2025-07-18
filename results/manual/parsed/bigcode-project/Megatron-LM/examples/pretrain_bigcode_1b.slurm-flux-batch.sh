#!/bin/bash
#FLUX: --job-name=1b-starcoder
#FLUX: -N=16
#FLUX: -c=38
#FLUX: --queue=production-cluster
#FLUX: --urgency=16

export LAUNCHER='python -u -m torch.distributed.run \'
export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_PROTO='simple'
export RDMAV_FORK_SAFE='1'
export FI_EFA_FORK_SAFE='1'
export FI_EFA_USE_DEVICE_RDMA='1'
export FI_PROVIDER='efa'
export FI_LOG_LEVEL='1'
export NCCL_IB_DISABLE='1'
export NCCL_SOCKET_IFNAME='ens'
export CUDA_HOME='/usr/local/cuda-11.6'

set -x -e
source /admin/home/loubna/.bashrc
conda activate megatron
echo "START TIME: $(date)"
SCRIPT_REPO=/fsx/loubna/code/Megatron-LM
pushd $SCRIPT_REPO
LOG_PATH=$SCRIPT_REPO/main_log.txt
GPUS_PER_NODE=8
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
NNODES=$SLURM_NNODES
NODE_RANK=$SLURM_PROCID
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
CHECKPOINT_PATH=/fsx/bigcode/experiments/pretraining/1b  # Adjust: Directory to store the checkpoints
TOKENIZER_FILE=/fsx/loubna/starcoder-tokenizer/15b/tokenizer.json
WEIGHTS_TRAIN=/fsx/bigcode/bigcode-training/code/bigcode-data-mix/data/train_data_paths.txt.tmp
WEIGHTS_VALID=/fsx/bigcode/bigcode-training/code/bigcode-data-mix/data/valid_data_paths.txt.tmp
mkdir -p $CHECKPOINT_PATH/tensorboard
GPT_ARGS="\
       --tensor-model-parallel-size 1 \
       --pipeline-model-parallel-size 1 \
       --num-layers 24 \
       --hidden-size 2048 \
       --num-attention-heads 16 \
       --attention-head-type multiquery \
       --init-method-std 0.02209 \
       --seq-length 8192 \
       --max-position-embeddings 8192 \
       --attention-dropout 0.1 \
       --hidden-dropout 0.1 \
       --micro-batch-size 1 \
       --global-batch-size 128 \
       --lr 0.0004 \
       --min-lr 0.00004 \
       --train-iters 1000000 \
       --lr-decay-iters 1000000 \
       --lr-decay-style cosine \
       --lr-warmup-iters 2000 \
       --weight-decay .1 \
       --adam-beta2 .95 \
       --clip-grad 1.0 \
       --bf16 \
       --use-flash-attn \
       --fim-rate 0.5 \
       --log-interval 10 \
       --save-interval 10000 \
       --eval-interval 10000 \
       --eval-iters 2 \
       --valid-num-workers 0 \
"
TENSORBOARD_ARGS="--tensorboard-dir /fsx/bigcode/experiments/pretraining/1b/tensorboard"
CMD=" \
    /fsx/loubna/code/Megatron-LM/pretrain_gpt.py \
    $GPT_ARGS \
    --tokenizer-type TokenizerFromFile \
    --tokenizer-file $TOKENIZER_FILE \
    --save $CHECKPOINT_PATH \
    --load $CHECKPOINT_PATH \
    --train-weighted-split-paths-path $WEIGHTS_TRAIN \
    --valid-weighted-split-paths-path $WEIGHTS_VALID \
    --structured-logs \
    --structured-logs-dir $CHECKPOINT_PATH/logs \
    $TENSORBOARD_ARGS \
    --wandb-entity-name loubnabnl \
    --wandb-project-name bigcode-pretraining \
    "
export LAUNCHER="python -u -m torch.distributed.run \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --rdzv_endpoint $MASTER_ADDR:$MASTER_PORT \
    --rdzv_backend c10d \
    --max_restarts 0 \
    --tee 3 \
    "
echo $CMD
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_PROTO=simple
export RDMAV_FORK_SAFE=1
export FI_EFA_FORK_SAFE=1
export FI_EFA_USE_DEVICE_RDMA=1
export FI_PROVIDER=efa
export FI_LOG_LEVEL=1
export NCCL_IB_DISABLE=1
export NCCL_SOCKET_IFNAME=ens
export CUDA_HOME=/usr/local/cuda-11.6
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    "
clear; srun $SRUN_ARGS --jobid $SLURM_JOB_ID bash -c "$LAUNCHER --node_rank \$SLURM_PROCID --role \$SLURMD_NODENAME: $CMD" 2>&1 | tee $LOG_PATH
echo "END TIME: $(date)"
