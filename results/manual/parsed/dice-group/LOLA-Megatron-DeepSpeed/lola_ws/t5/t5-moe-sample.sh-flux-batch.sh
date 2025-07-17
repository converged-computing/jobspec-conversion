#!/bin/bash
#FLUX: --job-name=T5 - MoE Sample
#FLUX: -t=7200
#FLUX: --urgency=16

export CUDA_LAUNCH_BLOCKING='1'
export TORCHELASTIC_ERROR_FILE='${OUTPUT_BASEPATH}/torch-elastic-error.json'
export NCCL_ASYNC_ERROR_HANDLING='1'
export LAUNCHER='python -u -m torch.distributed.run \'
export CMD='${LIB_DIR}/pretrain_t5_moe.py ${megatron_options} ${data_options} ${deepspeed_options}'

module load lib/NCCL/2.12.12-GCCcore-11.3.0-CUDA-11.7.0
module load ai/PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
module load vis/torchvision/0.13.1-foss-2022a-CUDA-11.7.0
source /scratch/hpc-prf-lola/lib_repo/custom-venvs/lola1/bin/activate
LIB_DIR=/scratch/hpc-prf-lola/nikit/repos/Megatron-DeepSpeed-Microsoft
DATA_DIR=data
OUTPUT_DIR=`pwd`
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6005
GPUS_PER_NODE=$SLURM_GPUS_ON_NODE
NNODES=$SLURM_NNODES
SEQ_LEN=2048
MODEL_SIZE=00
NUM_LAYERS=12
HIDDEN_SIZE=768
NUM_ATTN_HEADS=12
MICRO_BATCH_SIZE=1
KV_CHANNELS=64
FFN_HIDDEN_SIZE=3072
ENC_SEQ_LEN=$SEQ_LEN
DEC_SEQ_LEN=$((SEQ_LEN / 4))
LR=2.0e-4
MIN_LR=2e-06
GLOBAL_BATCH_SIZE=$((NNODES*GPUS_PER_NODE*MICRO_BATCH_SIZE))
TRAIN_TOKENS=300000000000
TRAIN_ITERS=$(( ${TRAIN_TOKENS} * 3 / ${GLOBAL_BATCH_SIZE} / ${SEQ_LEN} ))
EXIT_DURATION=30000000
WARMUP_TOKENS=375000000
LR_DECAY_TOKENS=300000000000
MP_SIZE=1
PP_SIZE=1
NUM_GPUS=$((NNODES*GPUS_PER_NODE))
EP_SIZE=4
if [[ $EP_SIZE -gt $NUM_GPUS ]]; then
    EP_PARALLEL_SIZE=$NUM_GPUS
else
    EP_PARALLEL_SIZE=$EP_SIZE
fi
MLC=0.01
MOE_TRAIN_CAP_FACTOR=1.0
MOE_EVAL_CAP_FACTOR=1.0
MOE_MIN_CAP=4
MOE_DROP_TOKEN="true"
CL_ENABLED="false"
CL_START_SEQLEN=80
CL_AVG_SEQLEN=$(( (${CL_START_SEQLEN} + ${SEQ_LEN}) / 2 ))
CL_TOKENS=60
CL_TOKENS=$((${CL_TOKENS} * 1000000000))
CL_STEP=$(( ${CL_TOKENS} / (${GLOBAL_BATCH_SIZE} * ${CL_AVG_SEQLEN}) ))
LOG_INTERVAL=5
EVAL_ITERS=50
EVAL_INTERVAL=100
SAVE_INTERVAL=100
INIT_STD=0.01
ACTIVATION_CHECKPOINT="true"
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
host="${HOSTNAME}"
NAME="gpt-${MODEL_SIZE}B-lr-${LR}-minlr-${MIN_LR}-bs-${GLOBAL_BATCH_SIZE}-gpus-${NUM_GPUS}-mp-${MP_SIZE}-pp-${PP_SIZE}"
if [[ $EP_SIZE -gt 1 ]]; then
    NAME="${NAME}-ep-${EP_SIZE}-mlc-${MLC}-cap-${MOE_TRAIN_CAP_FACTOR}-drop-${MOE_DROP_TOKEN}"
fi
if [ "${CL_ENABLED}" = "true" ]; then
    NAME="${NAME}-cl-${CL_START_SEQLEN}-${CL_STEP}"
fi
OUTPUT_BASEPATH=$OUTPUT_DIR/output
mkdir -p "${OUTPUT_BASEPATH}/tensorboard/"
mkdir -p "${OUTPUT_BASEPATH}/checkpoint/"
mkdir -p "${OUTPUT_BASEPATH}/log/"
TENSORBOARD_DIR="${OUTPUT_BASEPATH}/tensorboard/${NAME}_${host}_${current_time}"
mkdir -p ${TENSORBOARD_DIR}
CHECKPOINT_PATH="${OUTPUT_BASEPATH}/checkpoint/${NAME}"
DATA_BLEND=$DATA_DIR/meg-t5-mc4-sample-9k_text_document
data_options=" \
         --tokenizer-type SentencePieceTokenizer \
         --tokenizer-model ${DATA_DIR}/spiece.model \
         --data-path ${DATA_BLEND} \
         --vocab-extra-ids 100 \
         --data-impl mmap"
megatron_options=" \
        --override-opt_param-scheduler \
        --adam-beta1 0.9 \
        --adam-beta2 0.95 \
        --tensor-model-parallel-size ${MP_SIZE} \
        --moe-expert-parallel-size ${EP_PARALLEL_SIZE} \
        --num-experts ${EP_SIZE} \
        --moe-loss-coeff ${MLC} \
        --moe-train-capacity-factor ${MOE_TRAIN_CAP_FACTOR} \
        --moe-eval-capacity-factor ${MOE_EVAL_CAP_FACTOR} \
        --moe-min-capacity ${MOE_MIN_CAP} \
        --init-method-std ${INIT_STD} \
        --lr-decay-tokens ${LR_DECAY_TOKENS} \
        --lr-warmup-tokens ${WARMUP_TOKENS} \
        --micro-batch-size ${MICRO_BATCH_SIZE} \
        --exit-duration-in-mins ${EXIT_DURATION} \
        --global-batch-size ${GLOBAL_BATCH_SIZE} \
        --num-layers ${NUM_LAYERS} \
        --decoder-num-layers ${NUM_LAYERS} \
        --hidden-size ${HIDDEN_SIZE} \
        --num-attention-heads ${NUM_ATTN_HEADS} \
        --kv-channels ${KV_CHANNELS} \
        --ffn-hidden-size ${FFN_HIDDEN_SIZE} \
        --encoder-seq-length ${ENC_SEQ_LEN} \
        --decoder-seq-length ${DEC_SEQ_LEN} \
        --max-position-embeddings ${SEQ_LEN} \
        --train-tokens ${TRAIN_TOKENS} \
        --train-iters ${TRAIN_ITERS} \
        --lr ${LR} \
        --min-lr ${MIN_LR} \
        --lr-decay-style cosine \
        --split 98,2,0 \
        --log-interval ${LOG_INTERVAL} \
        --eval-interval ${EVAL_INTERVAL} \
        --eval-iters ${EVAL_ITERS} \
        --save-interval ${SAVE_INTERVAL} \
        --weight-decay 0.1 \
        --clip-grad 1.0 \
        --hysteresis 2 \
        --num-workers 0 \
        --fp16 \
        --load ${CHECKPOINT_PATH} \
        --save ${CHECKPOINT_PATH} \
        --tensorboard-queue-size 1 \
        --log-timers-to-tensorboard \
        --log-batch-size-to-tensorboard \
        --log-validation-ppl-to-tensorboard \
        --tensorboard-dir ${TENSORBOARD_DIR}"
if [ "${ACTIVATION_CHECKPOINT}" = "true" ]; then
megatron_options="${megatron_options} \
        --checkpoint-activations"
fi
if [[ $EP_SIZE -gt 1 ]]; then
megatron_options="${megatron_options} \
        --create-moe-param-group"
fi
if [ "${MOE_DROP_TOKEN}" = "false" ]; then
megatron_options="${megatron_options} \
        --disable-moe-token-dropping"
fi
ZERO_STAGE=2
template_json="../ds_config_gpt_Zero2_TEMPLATE.json"
config_json="${OUTPUT_BASEPATH}/ds_config_gpt_${NAME}.json"
sed "s/CONFIG_BATCH_SIZE/${GLOBAL_BATCH_SIZE}/" ${template_json} \
    | sed "s/CONFIG_MBSIZE/${MICRO_BATCH_SIZE}/" \
    | sed "s/LOG_INTERVAL/${LOG_INTERVAL}/" \
    | sed "s/ZERO_STAGE/${ZERO_STAGE}/" \
    | sed "s/PRESCALE_GRAD/true/" \
    | sed "s/CONFIG_FP16_ENABLED/true/" \
    | sed "s/CONFIG_BF16_ENABLED/false/" \
    | sed "s/CONFIG_CL_ENABLED/${CL_ENABLED}/" \
    | sed "s/CONFIG_CL_MIN/${CL_START_SEQLEN}/" \
    | sed "s/CONFIG_CL_MAX/${SEQ_LEN}/" \
    | sed "s/CONFIG_CL_DURATION/${CL_STEP}/" \
	  > ${config_json}
deepspeed_options=" \
		    --deepspeed \
		    --deepspeed_config ${config_json} \
        --zero-stage ${ZERO_STAGE} \
		    --pipeline-model-parallel-size ${PP_SIZE}"
if [[ $EP_SIZE -gt 1 ]]; then
deepspeed_options="${deepspeed_options} \
        --no-pipeline-parallel"
fi
if [ "${ACTIVATION_CHECKPOINT}" = "true" ]; then
deepspeed_options="${deepspeed_options} \
        --deepspeed-activation-checkpointing"
fi
export CUDA_LAUNCH_BLOCKING=1
export TORCHELASTIC_ERROR_FILE="${OUTPUT_BASEPATH}/torch-elastic-error.json"
export NCCL_ASYNC_ERROR_HANDLING=1
export LAUNCHER="python -u -m torch.distributed.run \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --rdzv_id=$RANDOM \
    --rdzv_endpoint $MASTER_ADDR:$MASTER_PORT \
    --rdzv_backend c10d \
    --max_restarts 0 \
    --tee 3 \
    "
export CMD="${LIB_DIR}/pretrain_t5_moe.py ${megatron_options} ${data_options} ${deepspeed_options}"
echo LAUNCHER: $LAUNCHER
echo CMD: $CMD
srun --wait=60 --kill-on-bad-exit=1 bash -c "NCCL_DEBUG=INFO $LAUNCHER --node_rank \$SLURM_PROCID $CMD" 2>&1 | tee -a ${OUTPUT_BASEPATH}/log/${NAME}_${host}_${current_time}.log
set -x
