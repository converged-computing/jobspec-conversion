#!/bin/bash
#FLUX: --job-name=Fast Setup - mini GPT2 train
#FLUX: --queue=dgx
#FLUX: -t=1800
#FLUX: --urgency=16

export LAUNCHER='python -u -m torch.distributed.run \'
export CMD=' \'
export CUDA_LAUNCH_BLOCKING='1'
export TORCHELASTIC_ERROR_FILE='torch-elastic-error.json'
export NCCL_ASYNC_ERROR_HANDLING='1'

module load lib/NCCL/2.12.12-GCCcore-11.3.0-CUDA-11.7.0
module load ai/PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
module load vis/torchvision/0.13.1-foss-2022a-CUDA-11.7.0
source /scratch/hpc-prf-lola/lib_repo/custom-venvs/lola1/bin/activate
DATE_POSTFIX=$(date '+%Y-%m-%d_%H%M%S')
MODEL_SIZE=0.35
CHECKPOINT_PATH=checkpoints/gpt2-${MODEL_SIZE}b-dist-${DATE_POSTFIX}
VOCAB_FILE=data/gpt2-vocab.json
MERGE_FILE=data/gpt2-merges.txt
DATA_PATH=data/meg-gpt2-oscar-en-10k_text_document
TENSORBOARD_PATH=output_dir/tensorboard-dist-$DATE_POSTFIX
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6005
GPUS_PER_NODE=$SLURM_GPUS_ON_NODE
NNODES=$SLURM_NNODES
MICRO_BATCH_SIZE=1
GLOBAL_BATCH_SIZE=$((SLURM_NNODES*SLURM_GPUS_ON_NODE*MICRO_BATCH_SIZE))
TP_SIZE=1
PP_SIZE=1
NLAYERS=24
NHIDDEN=1024
NHEADS=16
SEQ_LEN=1024
VOCAB_SIZE=50257
SAVE_INTERVAL=500
EPOCH=10
TRAIN_SAMPLES=10000
GPT_ARGS=" \
    --num-layers $NLAYERS \
    --hidden-size $NHIDDEN \
    --num-attention-heads $NHEADS \
    --seq-length $SEQ_LEN \
    --max-position-embeddings $SEQ_LEN \
    --micro-batch-size $MICRO_BATCH_SIZE \
    --global-batch-size $GLOBAL_BATCH_SIZE \
    --train-samples $((TRAIN_SAMPLES*EPOCH)) \
    --optimizer adam \
    --adam-beta1 0.9 \
    --adam-beta2 0.95 \
    --adam-eps 1e-8 \
    --lr 1e-4 \
    --min-lr 1e-6 \
    --lr-decay-style cosine \
    --clip-grad 1.0 \
    --weight-decay 1e-1 \
    --fp16 \
    --partition-activations \
    --seed 42 \
    --vocab-file $VOCAB_FILE \
    --merge-file $MERGE_FILE \
    "
OUTPUT_ARGS=" \
    --exit-interval 1000 \
    --log-interval 1 \
    --save-interval $SAVE_INTERVAL \
    --eval-interval 50 \
    --eval-iters 10 \
    --checkpoint-activations \
    "
DATA_ARGS=" \
    --save $CHECKPOINT_PATH \
    --load $CHECKPOINT_PATH \
    --data-path $DATA_PATH \
    --tensorboard-dir $TENSORBOARD_PATH \
    --tensorboard-queue-size 5 \
    --log-timers-to-tensorboard \
    --log-batch-size-to-tensorboard \
    --log-validation-ppl-to-tensorboard \
    "
ZERO_STAGE=2
config_json="./ds_config.json"
cat <<EOT > $config_json
{
  "train_micro_batch_size_per_gpu": $MICRO_BATCH_SIZE,
  "train_batch_size": $GLOBAL_BATCH_SIZE,
  "gradient_clipping": 1.0,
  "zero_optimization": {
    "stage": $ZERO_STAGE,
    "contiguous_gradients": true,
    "overlap_comm": true,
    "reduce_scatter": true,
    "reduce_bucket_size": 5e8,
    "allgather_bucket_size": 5e8
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
    --no-pipeline-parallel \
    --zero-stage ${ZERO_STAGE} \
    --deepspeed_config ${config_json} \
    --deepspeed-activation-checkpointing \
    "
ALL_ARGS="$GPT_ARGS $OUTPUT_ARGS $DATA_ARGS $DEEPSPEED_ARGS"
export LAUNCHER="python -u -m torch.distributed.run \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --rdzv_id=$RANDOM \
    --rdzv_endpoint $MASTER_ADDR:$MASTER_PORT \
    --rdzv_backend c10d \
    --max_restarts 0 \
    --tee 3 \
    "
export CMD=" \
    pretrain_gpt.py \
    --tensor-model-parallel-size $TP_SIZE \
    --pipeline-model-parallel-size $PP_SIZE \
    --distributed-backend nccl \
    $ALL_ARGS \
    "
export CUDA_LAUNCH_BLOCKING=1
export TORCHELASTIC_ERROR_FILE='torch-elastic-error.json'
export NCCL_ASYNC_ERROR_HANDLING=1
echo LAUNCHER: $LAUNCHER
echo CMD: $CMD
srun --wait=60 --kill-on-bad-exit=1 bash -c "NCCL_DEBUG=INFO $LAUNCHER --node_rank \$SLURM_PROCID $CMD" 2>&1 | tee -a gpt2-dist.log
