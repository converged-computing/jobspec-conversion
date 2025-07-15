#!/bin/bash
#FLUX: --job-name=expensive-latke-6884
#FLUX: -N=8
#FLUX: -c=16
#FLUX: --queue=gpu_p5
#FLUX: -t=18000
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='$ajs_ALL_CCFRWORK/models'
export HF_DATASETS_CACHE='$ajs_ALL_CCFRWORK/datasets'
export HF_MODULES_CACHE='$ajs_ALL_CCFRWORK/modules'
export HF_METRICS_CACHE='$ajs_ALL_CCFRWORK/metrics'
export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'
export LAUNCHER='python -u -m torch.distributed.run \'
export CMD=' \'
export CUDA_LAUNCH_BLOCKING='1'
export TORCHELASTIC_ERROR_FILE='/tmp/torch-elastic-error.json'

set -x -e
source $six_ALL_CCFRWORK/code/tr11-176B-ml/bigscience/train/tr11-176B-ml/start-tr11-176B-ml
echo "START TIME: $(date)"
variant=main
DATA_PATH=$ajs_ALL_CCFRSCRATCH/datasets/c4/gpt2tok_c4_text_document
DATA_OUTPUT_PATH=$ajs_ALL_CCFRSCRATCH/checkpoints/tr14-2B7-lr$1-init0.1-inpm10-outm10-atnm10-mup
CHECKPOINT_PATH=$DATA_OUTPUT_PATH/checkpoints/$variant
REPO_PATH=$DATA_OUTPUT_PATH/tr14-2B7-test-lr$1-init0.1-inpm10-outm10-atnm10-mup
TENSORBOARD_PATH=$REPO_PATH/tensorboard/$variant
LOGS_PATH=$REPO_PATH/logs/$variant
mkdir -p $LOGS_PATH
MEGATRON_DEEPSPEED_REPO=$ajs_ALL_CCFRWORK/code/Megatron-DeepSpeed
cd $MEGATRON_DEEPSPEED_REPO
TOKENIZER_NAME_OR_PATH=t5-small
export TRANSFORMERS_CACHE=$ajs_ALL_CCFRWORK/models
export HF_DATASETS_CACHE=$ajs_ALL_CCFRWORK/datasets
export HF_MODULES_CACHE=$ajs_ALL_CCFRWORK/modules
export HF_METRICS_CACHE=$ajs_ALL_CCFRWORK/metrics
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
GPUS_PER_NODE=8
NNODES=$SLURM_NNODES
PP_SIZE=1
TP_SIZE=2
MICRO_BATCH_SIZE=16
GLOBAL_BATCH_SIZE=512
NLAYERS=32
NHIDDEN=2560
NHEADS=32
SEQ_LEN=2048
SAVE_INTERVAL=250
TRAIN_SAMPLES=1_953_125  # 50B tokens
LR_DECAY_SAMPLES=1_953_125  # Decay in the same amount
LR_WARMUP_SAMPLES=183_105  # 375M tokens
MUP_ARGS=" \
    --lr $1 \
    --min-lr `bc <<< "scale=3; $1/10"` \
    --init-method-std 0.1 \
    --mup \
    --mup-input-mult 10 \
    --mup-output-mult 10 \
    --mup-attn-mult 10 \
"
OPTIMIZER_ARGS=" \
    --optimizer adam \
    --adam-beta1 0.9 \
    --adam-beta2 0.95 \
    --adam-eps 1e-8 \
    --lr-decay-style cosine \
    --lr-decay-samples $LR_DECAY_SAMPLES \
    --lr-warmup-samples $LR_WARMUP_SAMPLES \
    --clip-grad 1.0 \
    --weight-decay 1e-1 \
    "
EXIT_OPTS=" \
    --exit-duration-in-mins 1190 \
    "
GPT_ARGS=" \
    --pp-partition-method 'type:transformer' \
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
    --embed-layernorm \
    --fp16 \
    --seed 42 \
    --position-embedding-type alibi \
    --checkpoint-activations \
    --abort-on-unmet-fused-kernel-constraints \
    --pad-vocab-size-to 51200 \
    $OPTIMIZER_ARGS \
    $EXIT_OPTS \
    "
OUTPUT_ARGS=" \
    --log-interval 1 \
    --save-interval $SAVE_INTERVAL \
    --eval-interval 1000 \
    --eval-iters 1 \
    --tensorboard-dir $TENSORBOARD_PATH \
    --tensorboard-queue-size 5 \
    --log-timers-to-tensorboard \
    --log-batch-size-to-tensorboard \
    --log-validation-ppl-to-tensorboard \
    "
ZERO_STAGE=1
config_json="./ds_config.$SLURM_JOBID.json"
cat <<EOT > $config_json
{
  "train_micro_batch_size_per_gpu": $MICRO_BATCH_SIZE,
  "train_batch_size": $GLOBAL_BATCH_SIZE,
  "gradient_clipping": 1.0,
  "zero_optimization": {
    "stage": $ZERO_STAGE
  },
  "fp16": {
    "enabled": true,
    "loss_scale": 0,
    "loss_scale_window": 500,
    "hysteresis": 2,
    "min_loss_scale": 1,
    "initial_scale_power": 12
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
    `pwd`/pretrain_gpt.py \
    --tensor-model-parallel-size $TP_SIZE \
    --pipeline-model-parallel-size $PP_SIZE \
    $GPT_ARGS \
    $OUTPUT_ARGS \
    $MUP_ARGS \
    --save $CHECKPOINT_PATH \
    --load $CHECKPOINT_PATH \
    --data-path $DATA_PATH \
    --data-impl mmap \
    --distributed-backend nccl \
     $DEEPSPEED_ARGS \
    "
echo $CMD
export CUDA_LAUNCH_BLOCKING=1
export TORCHELASTIC_ERROR_FILE=/tmp/torch-elastic-error.json
clear; srun --jobid $SLURM_JOBID bash -c "$LAUNCHER --node_rank \$SLURM_PROCID $CMD" 2>&1 | tee -a $LOGS_PATH/main_log.txt
echo "END TIME: $(date)"
