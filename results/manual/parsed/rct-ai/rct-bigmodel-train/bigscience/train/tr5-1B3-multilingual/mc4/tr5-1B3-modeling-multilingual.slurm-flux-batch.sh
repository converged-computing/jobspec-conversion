#!/bin/bash
#FLUX: --job-name=1B3-multilingual.slurm
#FLUX: -N=16
#FLUX: -c=40
#FLUX: -t=72000
#FLUX: --urgency=16

export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'
export LAUNCHER='python -u -m torch.distributed.launch \'
export CMD=' \'

set -x -e
source $six_ALL_CCFRWORK/start-prod
ROUND=2
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
OUTPUT_PATH=$six_ALL_CCFRSCRATCH/checkpoints/tr5-1B3-multilingual
MEGATRON_DEEPSPEED_REPO=$OUTPUT_PATH/code/Megatron-DeepSpeed
BIGSCIENCE_REPO=$OUTPUT_PATH/code/bigscience
python $BIGSCIENCE_REPO/train/tr5-1B3-multilingual/generate_dataset_probabilities.py
DATA_PATH=`cat $OUTPUT_PATH/dataset_probabilities.txt`
pushd $MEGATRON_DEEPSPEED_REPO
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
GPUS_PER_NODE=4
NNODES=16
PP_SIZE=4 # NLAYERS must be a multiple of PP_SIZE here
TP_SIZE=4 # always fixed to the size of a single node
DP_SIZE=$((NNODES*GPUS_PER_NODE/(PP_SIZE*TP_SIZE))) # will get derived automatically by trainer
MICRO_BATCH_SIZE=4
GLOBAL_BATCH_SIZE=512
TRAIN_ITER=73_242_187
NLAYERS=24
NHIDDEN=2048
NHEADS=16
FFN_HIDDEN_SIZE=8192
SEQ_LEN=2048
if   [[ ${ROUND} == 1 ]]; then  EXIT_INTERVAL=100    SAVE_INTERVAL=10
elif [[ ${ROUND} == 2 ]]; then  SAVE_INTERVAL=1500
else echo "invalid ROUND: $ROUND"
fi
OPTIMIZER_ARGS=" \
    --optimizer adam \
    --adam-beta1 0.9 \
    --adam-beta2 0.999 \
    --adam-eps 1e-8 \
    --lr 2e-4 \
    --min-lr 1e-5 \
    --lr-decay-style cosine \
    --lr-decay-samples 73_242_187 \
    --lr-warmup-samples 183_105 \
    --clip-grad 1.0 \
    --weight-decay 1e-1 \
    "
EXIT_OPTS=" \
    --exit-duration-in-mins 1190 \
    "
GPT_ARGS=" \
    --num-layers $NLAYERS \
    --hidden-size $NHIDDEN \
    --num-attention-heads $NHEADS \
    --ffn-hidden-size $FFN_HIDDEN_SIZE \
    --seq-length $SEQ_LEN \
    --max-position-embeddings $SEQ_LEN \
    --micro-batch-size $MICRO_BATCH_SIZE \
    --global-batch-size $GLOBAL_BATCH_SIZE \
    --rampup-batch-size 16 16 2_000_000 \
    --train-samples $TRAIN_ITER \
    --tokenizer-type PretrainedFromHF \
    --tokenizer-name-or-path google/mt5-base \
    --loss-scale 12 \
    --clip-grad 1.0 \
    --fp16 \
    --checkpoint-activations \
    $OPTIMIZER_ARGS \
    $EXIT_OPTS \
    "
OUTPUT_ARGS=" \
    --log-interval 200 \
    --save-interval $SAVE_INTERVAL \
    --eval-interval 1000 \
    --eval-iters 100 \
    --tensorboard-dir $OUTPUT_PATH/tensorboard \
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
export LAUNCHER="python -u -m torch.distributed.launch \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --master_addr $MASTER_ADDR \
    --master_port $MASTER_PORT \
    "
export CMD=" \
    `pwd`/pretrain_gpt.py \
    --tensor-model-parallel-size $TP_SIZE \
    --pipeline-model-parallel-size $PP_SIZE \
    $GPT_ARGS \
    $OUTPUT_ARGS \
    --save $OUTPUT_PATH/checkpoints \
    --load $OUTPUT_PATH/checkpoints \
    --data-path $DATA_PATH \
    --data-impl mmap \
    --split 949,50,1 \
    --distributed-backend nccl \
     $DEEPSPEED_ARGS \
    "
echo $CMD
srun --jobid $SLURM_JOBID bash -c '$LAUNCHER --node_rank $SLURM_PROCID $CMD' 2>&1 | tee $OUTPUT_PATH/logs/tr3-1B3-modeling-baseline.$SLURM_JOBID.out
