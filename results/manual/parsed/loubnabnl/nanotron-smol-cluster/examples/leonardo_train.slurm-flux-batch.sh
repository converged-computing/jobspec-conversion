#!/bin/bash
#FLUX: --job-name=train
#FLUX: -N=32
#FLUX: -c=32
#FLUX: --exclusive
#FLUX: --queue=boost_usr_prod
#FLUX: --urgency=16

export CUDA_HOME='$CONDA_PREFIX'
export LIBRARY_PATH='$CONDA_PREFIX/lib:$LIBRARY_PATH'
export LD_LIBRARY_PATH='$CONDA_PREFIX/lib:$LD_LIBRARY_PATH'
export LAUNCHER='python -u -m torch.distributed.run \'

set -x -e
source /leonardo/home/userexternal/lbenalla/.bashrc
conda activate megatron-2
export CUDA_HOME=$CONDA_PREFIX
export LIBRARY_PATH=$CONDA_PREFIX/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH
echo "START TIME: $(date)"
SCRIPT_REPO=/leonardo/home/userexternal/lbenalla/code/Megatron-LM
pushd $SCRIPT_REPO
LOG_PATH=$SCRIPT_REPO/main_log.txt
GPUS_PER_NODE=4
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
NNODES=$SLURM_NNODES
NODE_RANK=$SLURM_PROCID
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
CHECKPOINT_PATH=/leonardo_scratch/large/userexternal/lbenalla/trainings/ckpts
TOKENIZER_FILE=/leonardo/home/userexternal/lbenalla/tokenizer-starcoder/tokenizer.json
WEIGHTS_TRAIN=/leonardo/home/userexternal/lbenalla/code/bigcode-data-mix/data/train_data_paths.txt.tmp
WEIGHTS_VALID=/leonardo/home/userexternal/lbenalla/code/bigcode-data-mix/data/valid_data_paths.txt.tmp
mkdir -p $CHECKPOINT_PATH/tensorboard
GPT_ARGS="\
       --tensor-model-parallel-size 4 \
       --pipeline-model-parallel-size 4 \
       --sequence-parallel \
       --num-layers 40 \
       --hidden-size 6144 \
       --num-attention-heads 48 \
       --attention-head-type multiquery \
       --init-method-std 0.01275 \
       --seq-length 4096 \
       --max-position-embeddings 4096 \
       --attention-dropout 0.1 \
       --hidden-dropout 0.1 \
       --micro-batch-size 1 \
       --global-batch-size 512 \
       --lr 0.0003 \
       --min-lr 0.00003 \
       --train-iters 250000 \
       --lr-decay-iters 250000 \
       --lr-decay-style cosine \
       --lr-warmup-iters 2000 \
       --weight-decay .1 \
       --adam-beta2 .95 \
       --clip-grad 1.0 \
       --fp16 \
       --use-flash-attn \
       --fim-rate 0.5 \
       --log-interval 10 \
       --save-interval 2500 \
       --eval-interval 2500 \
       --eval-iters 2 \
       --use-distributed-optimizer \
       --valid-num-workers 0 \
"
TENSORBOARD_ARGS="--tensorboard-dir ${CHECKPOINT_PATH}/tensorboard"
CMD=" \
    /leonardo/home/userexternal/lbenalla/code/Megatron-LM/pretrain_gpt.py \
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
    --wandb-project-name leonardo-training \
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
clear; srun $SRUN_ARGS --jobid $SLURM_JOB_ID bash -c "$LAUNCHER --node_rank \$SLURM_PROCID --role \$SLURMD_NODENAME: $CMD" 2>&1 | tee $LOG_PATH
echo "END TIME: $(date)"
