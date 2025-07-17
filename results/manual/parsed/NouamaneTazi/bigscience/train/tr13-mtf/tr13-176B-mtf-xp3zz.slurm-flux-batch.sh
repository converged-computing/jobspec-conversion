#!/bin/bash
#FLUX: --job-name=tr13-176B-ml-xp3zz
#FLUX: -N=36
#FLUX: -c=64
#FLUX: --queue=gpu_p5
#FLUX: -t=360000
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='$six_ALL_CCFRWORK/models'
export HF_DATASETS_CACHE='$six_ALL_CCFRWORK/datasets'
export HF_MODULES_CACHE='$six_ALL_CCFRWORK/modules'
export HF_METRICS_CACHE='$six_ALL_CCFRWORK/metrics'
export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'
export LAUNCHER='python -u -m torch.distributed.run \'
export CMD=' \'
export CUDA_LAUNCH_BLOCKING='1'
export TORCHELASTIC_ERROR_FILE='/tmp/torch-elastic-error.json'
export NCCL_ASYNC_ERROR_HANDLING='1'

set -x -e
source $six_ALL_CCFRWORK/start-tr13f-6B3-ml-t0
echo "START TIME: $(date)"
variant=xp3zzlossseq
DATA_OUTPUT_PATH=$six_ALL_CCFRSCRATCH/checkpoints/tr13-176B-ml-t0
CHECKPOINT_PATH=$DATA_OUTPUT_PATH/checkpoints/$variant
REPO_PATH=$DATA_OUTPUT_PATH/tr13-176B-ml-t0-logs
TENSORBOARD_PATH=$REPO_PATH/tensorboard/$variant
LOGS_PATH=$REPO_PATH/logs/$variant
mkdir -p $LOGS_PATH
mkdir -p $TENSORBOARD_PATH
MEGATRON_DEEPSPEED_REPO=/gpfswork/rech/six/commun/code/tr13f-6B3-ml-t0/megdslossseqnew/Megatron-DeepSpeed
cd $MEGATRON_DEEPSPEED_REPO
KILL_SWITCH_PATH=$MEGATRON_DEEPSPEED_REPO/kill-switch-tr13-176B-mtf
TRAIN_DATA_PATH=$six_ALL_CCFRWORK/code/tr13f-6B3-ml-t0/Megatron-DeepSpeed/data/xp3zzlossseq_train.txt
VALID_DATA_PATH=$six_ALL_CCFRWORK/code/tr13f-6B3-ml-t0/Megatron-DeepSpeed/data/xp3capmixnewcodelong_validation_pretr_only.txt
TOKENIZER_NAME_OR_PATH=bigscience/tokenizer
export TRANSFORMERS_CACHE=$six_ALL_CCFRWORK/models
export HF_DATASETS_CACHE=$six_ALL_CCFRWORK/datasets
export HF_MODULES_CACHE=$six_ALL_CCFRWORK/modules
export HF_METRICS_CACHE=$six_ALL_CCFRWORK/metrics
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6001
GPUS_PER_NODE=8
NNODES=$SLURM_NNODES
PP_SIZE=72
TP_SIZE=1
MICRO_BATCH_SIZE=1
GLOBAL_BATCH_SIZE=2048
NHIDDEN=14336
NLAYERS=70
NHEADS=112
SEQ_LEN=2048
SAVE_INTERVAL=5
TRAIN_SAMPLES=6_348_800
OPTIMIZER_ARGS=" \
    --optimizer adam \
    --adam-beta1 0.9 \
    --adam-beta2 0.95 \
    --adam-eps 1e-8 \
    --lr 2e-5 \
    --lr-decay-style constant \
    --lr-warmup-samples 0 \
    --clip-grad 1.0 \
    --weight-decay 1e-4 \
    --no-load-optim \
    --norm-target-loss \
    --reset-progress \
    "
EXIT_OPTS=" \
    --exit-duration-in-mins 5990 \
    "
GPT_ARGS=" \
    --pp-partition-method 'type:transformer|embedding' \
    --num-layers $NLAYERS \
    --hidden-size $NHIDDEN \
    --num-attention-heads $NHEADS \
    --seq-length $SEQ_LEN \
    --max-position-embeddings $SEQ_LEN \
    --micro-batch-size $MICRO_BATCH_SIZE \
    --global-batch-size $GLOBAL_BATCH_SIZE \
    --train-samples $TRAIN_SAMPLES \
    --tokenizer-type PretrainedFromHF \
    --tokenizer-name-or-path $TOKENIZER_NAME_OR_PATH \
    --init-method-std 0.0048 \
    --embed-layernorm \
    --sync-tp-duplicated-parameters \
    --bf16 \
    --seed 42 \
    --position-embedding-type alibi \
    --checkpoint-activations \
    --abort-on-unmet-fused-kernel-constraints \
    --kill-switch-path $KILL_SWITCH_PATH \
    --pad-vocab-size-to 250880 \
    $OPTIMIZER_ARGS \
    $EXIT_OPTS \
    "
OUTPUT_ARGS=" \
    --log-interval 1 \
    --save-interval $SAVE_INTERVAL \
    --eval-interval 250 \
    --eval-iters 1 \
    --tensorboard-dir $TENSORBOARD_PATH \
    --tensorboard-queue-size 5 \
    --log-timers-to-tensorboard \
    --log-batch-size-to-tensorboard \
    --log-validation-ppl-to-tensorboard \
    "
ZERO_STAGE=0 # important: bf16 must use z0! it implements its own zero stage 1 equivalent
config_json="./ds_config.$SLURM_JOBID.json"
cat <<EOT > $config_json
{
  "train_micro_batch_size_per_gpu": $MICRO_BATCH_SIZE,
  "train_batch_size": $GLOBAL_BATCH_SIZE,
  "gradient_clipping": 1.0,
  "zero_optimization": {
    "stage": $ZERO_STAGE
  },
  "bf16": {
    "enabled": true
  },
  "steps_per_print": 2000,
  "wall_clock_breakdown": false
}
EOT
DEEPSPEED_ARGS=" \
    --deepspeed \
    --deepspeed_config ${config_json} \
    --zero-stage ${ZERO_STAGE} \
    --deepspeed-activation-checkpointing \
    "
export LAUNCHER="python -u -m torch.distributed.run \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --rdzv_endpoint $MASTER_ADDR:$MASTER_PORT \
    --rdzv_backend c10d \
    --max_restarts 0 \
    --tee 3 \
    "
export CMD=" \
    `pwd`/finetune_t0.py \
    --universal-checkpoint \
    --tensor-model-parallel-size $TP_SIZE \
    --pipeline-model-parallel-size $PP_SIZE \
    $GPT_ARGS \
    $OUTPUT_ARGS \
    --save $CHECKPOINT_PATH \
    --load $CHECKPOINT_PATH \
    --train-weighted-split-paths-path $TRAIN_DATA_PATH \
    --valid-weighted-split-paths-path $VALID_DATA_PATH \
    --dataloader-type single \
    --data-impl mmap \
    --distributed-backend nccl \
     $DEEPSPEED_ARGS \
    "
echo $CMD
export CUDA_LAUNCH_BLOCKING=1
export TORCHELASTIC_ERROR_FILE=/tmp/torch-elastic-error.json
export NCCL_ASYNC_ERROR_HANDLING=1
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    "
clear; srun $SRUN_ARGS --jobid $SLURM_JOBID bash -c "$LAUNCHER --node_rank \$SLURM_PROCID $CMD" 2>&1 | tee -a $LOGS_PATH/main_log.txt
echo "END TIME: $(date)"
