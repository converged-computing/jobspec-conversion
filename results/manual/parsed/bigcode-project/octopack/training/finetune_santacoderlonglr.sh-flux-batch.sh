#!/bin/bash
#FLUX: --job-name=santacoder
#FLUX: -N=2
#FLUX: -c=64
#FLUX: --queue=gpu_p5
#FLUX: -t=72000
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='$six_ALL_CCFRWORK/models'
export HF_DATASETS_CACHE='$six_ALL_CCFRWORK/datasets'
export HF_MODULES_CACHE='$six_ALL_CCFRWORK/modules'
export HF_METRICS_CACHE='$six_ALL_CCFRWORK/metrics'
export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'
export LAUNCHER='python -u -m torch.distributed.run \'
export CUDA_LAUNCH_BLOCKING='1'
export TORCHELASTIC_ERROR_FILE='/tmp/torch-elastic-error.json'
export NCCL_ASYNC_ERROR_HANDLING='1'

set -x -e
source $six_ALL_CCFRWORK/start-tr13f-6B3-ml-t0
export TRANSFORMERS_CACHE=$six_ALL_CCFRWORK/models
export HF_DATASETS_CACHE=$six_ALL_CCFRWORK/datasets
export HF_MODULES_CACHE=$six_ALL_CCFRWORK/modules
export HF_METRICS_CACHE=$six_ALL_CCFRWORK/metrics
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
echo "START TIME: $(date)"
GPUS_PER_NODE=8
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6001
NNODES=$SLURM_NNODES
NODE_RANK=$SLURM_PROCID
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
DISTRIBUTED_ARGS="--nproc_per_node $GPUS_PER_NODE --nnodes $NNODES --node_rank $NODE_RANK --master_addr $MASTER_ADDR --master_port $MASTER_PORT"
CHECKPOINT_PATH=/gpfswork/rech/ajs/commun/code/bigcode/finetune/santacoderlonglr
WEIGHTS_TRAIN=/gpfswork/rech/ajs/commun/code/bigcode/finetune/train_data_paths.txt.tmp
WEIGHTS_VALID=/gpfswork/rech/ajs/commun/code/bigcode/finetune/valid_data_paths.txt.tmp
TOKENIZER_FILE=/gpfswork/rech/ajs/commun/code/bigcode/bigcode-evaluation-harness/santacoder/tokenizer.json
LOG_PATH=$CHECKPOINT_PATH/main_log.txt
cd Megatron-LM
GPT_ARGS="\
--tensor-model-parallel-size 1 \
--pipeline-model-parallel-size 1 \
--recompute-activations \
--num-layers 24 \
--hidden-size 2048 \
--num-attention-heads 16 \
--attention-head-type multiquery \
--init-method-std 0.022 \
--seq-length 2048 \
--max-position-embeddings 2048 \
--attention-dropout 0.1 \
--hidden-dropout 0.1 \
--micro-batch-size 8 \
--global-batch-size 128 \
--lr 0.00005 \
--min-lr 0.000005 \
--train-iters 100000 \
--lr-decay-iters 100000 \
--lr-decay-style cosine \
--lr-warmup-fraction 0.01 \
--weight-decay .1 \
--adam-beta2 .95 \
--clip-grad 1.0 \
--fp16 \
--log-interval 10 \
--save-interval 10000 \
--eval-interval 5000 \
--eval-iters 10 \
--initial-loss-scale 65536 \
--valid-num-workers 0 \
--reset-progress \
--no-load-rng \
--no-load-optim \
--finetune \
--norm-target-loss \
--loss-on-targets-only \
"
TENSORBOARD_ARGS="--tensorboard-dir ${CHECKPOINT_PATH}/tensorboard"
CMD=" \
    finetune_mtf.py \
    $GPT_ARGS \
    --tokenizer-type TokenizerFromFileWithFIM \
    --tokenizer-file $TOKENIZER_FILE \
    --save $CHECKPOINT_PATH \
    --load $CHECKPOINT_PATH \
    --train-weighted-split-paths-path $WEIGHTS_TRAIN \
    --valid-weighted-split-paths-path $WEIGHTS_VALID \
    --structured-logs \
    --structured-logs-dir $CHECKPOINT_PATH/logs \
    $TENSORBOARD_ARGS \
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
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    "
export CUDA_LAUNCH_BLOCKING=1
export TORCHELASTIC_ERROR_FILE=/tmp/torch-elastic-error.json
export NCCL_ASYNC_ERROR_HANDLING=1
clear; srun $SRUN_ARGS --jobid $SLURM_JOB_ID bash -c "$LAUNCHER --node_rank \$SLURM_PROCID --role \$SLURMD_NODENAME: $CMD" 2>&1 | tee $LOG_PATH
echo "END TIME: $(date)"
