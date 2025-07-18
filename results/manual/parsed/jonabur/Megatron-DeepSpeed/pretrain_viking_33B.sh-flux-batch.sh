#!/bin/bash
#FLUX: --job-name=viking_v2_33B_high_eps
#FLUX: -N=256
#FLUX: -c=7
#FLUX: --exclusive
#FLUX: --queue=standard-g
#FLUX: -t=86400
#FLUX: --urgency=16

export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='9999'
export WORLD_SIZE='$SLURM_NTASKS'
export CC='gcc-10'
export CXX='g++-10'
export CUDA_DEVICE_MAX_CONNECTIONS='1'
export MEMORY_OPT_ALLREDUCE_SIZE='1250000000'
export PYTHONUSERBASE='pythonuserbase'

mkdir -p workdir
wd=$(realpath workdir)
if [ -z $SLURM_JOB_ID ]; then
    mkdir -p logs
    sbatch "$0"
    exit
fi
./log_restart_info.sh | tee -a starts.log
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=9999
export WORLD_SIZE=$SLURM_NTASKS
export CC=gcc-10
export CXX=g++-10
CONTAINER="/scratch/project_462000319/containers/vaino_flashattention_v2_new"
SING_BIND="/scratch/project_462000319,/flash/project_462000319,/scratch/project_462000086"
rm -rf separate-logs
mkdir -p separate-logs
LEARNING_RATE=1.5e-4    # Llama2 34B
set -euo pipefail
ln -f -s "${SLURM_JOB_ID}-33B_high_eps.out" logs-33B_high_eps/latest.out
ln -f -s "${SLURM_JOB_ID}-33B_high_eps.err" logs-33B_high_eps/latest.err
CHECKPOINT_PATH=/scratch/project_462000086/viking-v2/33B_high_eps
TENSORBOARD_PATH="tensorboard/33B_high_eps.${SLURM_JOB_ID}"
export CUDA_DEVICE_MAX_CONNECTIONS=1
TRAIN_DATA="0.07370182629 /scratch/project_462000319/viking_preprocessed_data/merged_datasets/finnish 0.3302641761 /scratch/project_462000319/viking_preprocessed_data/merged_datasets/slimpajama 0.330497442 /scratch/project_462000319/viking_preprocessed_data/merged_datasets/starcoderdata 0.08367352788 /scratch/project_462000319/viking_preprocessed_data/merged_datasets/nordic-en-xling-combined 0.002361170146 /scratch/project_462000319/viking_preprocessed_data/small_files/train-books_text_document 0.05157063372 /scratch/project_462000319/viking_preprocessed_data/nordics/mc4-da-train_text_document 0.004054463623 /scratch/project_462000319/viking_preprocessed_data/nordics/mc4-is-train_text_document 0.08052558051 /scratch/project_462000319/viking_preprocessed_data/nordics/mc4-sv-train_text_document 0.04188033719 /scratch/project_462000319/viking_preprocessed_data/nordics/nor_all_combined_text_document 0.001470842506 /scratch/project_462000319/viking_preprocessed_data/small_files/natural_instruct_train_text_document"
VALIDATION_DATA="0.07370182629 /scratch/project_462000319/viking_preprocessed_data/eval/finnish_eval_text_document 0.3302641761 /scratch/project_462000319/viking_preprocessed_data/eval/slim-pajama-validation_text_document 0.330497442 /scratch/project_462000319/viking_preprocessed_data/eval/starcoder-eval_content_document 0.08367352788 /scratch/project_462000319/viking_preprocessed_data/eval/xlint-test-all-combined_text_document 0.002361170146 /scratch/project_462000319/viking_preprocessed_data/eval/eval-books.json_text_document 0.05157063372 /scratch/project_462000319/viking_preprocessed_data/eval/mc4-da-validation_text_document 0.004054463623 /scratch/project_462000319/viking_preprocessed_data/eval/mc4-is-validation_text_document 0.08052558051 /scratch/project_462000319/viking_preprocessed_data/eval/mc4-sv-validation_text_document 0.04188033719 /scratch/project_462000319/viking_preprocessed_data/eval/nor_eval_all_text_document 0.001470842506 /scratch/project_462000319/viking_preprocessed_data/eval/natural_instruct_validation_text_document"
MERGES=/scratch/project_462000319/tokenizers/nordic_tokenizer_131072/merges.txt
VOCAB=/scratch/project_462000319/tokenizers/nordic_tokenizer_131072/vocab.json
PP_SIZE=4
TP_SIZE=4
MICRO_BATCH_SIZE=1
GLOBAL_BATCH_SIZE=1024
NLAYERS=56
NHIDDEN=7168
NHEADS=56
FFN_HIDDEN_SIZE=20480
SEQ_LEN=4096
export MEMORY_OPT_ALLREDUCE_SIZE=1250000000
echo "MEMORY_OPT_ALLREDUCE_SIZE $MEMORY_OPT_ALLREDUCE_SIZE"
TOTAL_TOKENS=2_000_000_000_000 # 2 trillion
TOTAL_TOKENS=${TOTAL_TOKENS//_}    # drop "_" for bash math
TRAIN_SAMPLES=$((TOTAL_TOKENS/SEQ_LEN))
LR_DECAY_SAMPLES=$TRAIN_SAMPLES
LR_WARMUP_SAMPLES=$((GLOBAL_BATCH_SIZE*2000))
SAVE_INTERVAL=1000
LOG_INTERVAL=10
EVAL_INTERVAL=4000
EVAL_STEPS=100
OPTIMIZER_ARGS=" \
    --optimizer adam \
    --adam-beta1 0.9 \
    --adam-beta2 0.95 \
    --adam-eps 1e-5  \
    --lr $LEARNING_RATE \
    --min-lr 1.5e-5 \
    --lr-decay-style cosine \
    --lr-decay-samples $LR_DECAY_SAMPLES \
    --lr-warmup-samples $LR_WARMUP_SAMPLES \
    --clip-grad 1.0 \
    --weight-decay 1e-1 \
    "
GPT_ARGS=" \
    --num-layers $NLAYERS \
    --hidden-size $NHIDDEN \
    --num-attention-heads $NHEADS \
    --ffn-hidden-size $FFN_HIDDEN_SIZE \
    --seq-length $SEQ_LEN \
    --num-key-value-heads 8 \
    --max-position-embeddings $SEQ_LEN \
    --micro-batch-size $MICRO_BATCH_SIZE \
    --global-batch-size $GLOBAL_BATCH_SIZE \
    --train-samples $TRAIN_SAMPLES \
    --tokenizer-type GPT2BPETokenizer \
    --vocab-file $VOCAB \
    --merge-file $MERGES \
    --bf16 \
    --disable-bias-linear \
    --init-method-std 0.0048 \
    --make-vocab-size-divisible-by 128 \
    --no-gradient-accumulation-fusion \
    --normalization rmsnorm \
    --recompute-activations \
    --seed 42 \
    --swiglu \
    --untie-embeddings-and-output-weights \
    --use-distributed-optimizer \
    --use-flash-attn-v2 \
    --use-rotary-position-embeddings \
    --attention-dropout 0 \
    --hidden-dropout 0 \
    --no-query-key-layer-scaling \
    $OPTIMIZER_ARGS \
    "
OUTPUT_ARGS=" \
    --log-interval $LOG_INTERVAL \
    --save-interval $SAVE_INTERVAL \
    --save $CHECKPOINT_PATH \
    --load $CHECKPOINT_PATH \
    --eval-interval $EVAL_INTERVAL \
    --eval-iters $EVAL_STEPS \
    --tensorboard-dir $TENSORBOARD_PATH \
    --tensorboard-queue-size 5 \
    --log-timers-to-tensorboard \
    --log-batch-size-to-tensorboard \
    --log-validation-ppl-to-tensorboard \
    "
CMD=" \
    pretrain_gpt.py \
    --tensor-model-parallel-size $TP_SIZE \
    --pipeline-model-parallel-size $PP_SIZE \
    $GPT_ARGS \
    $OUTPUT_ARGS \
    --train-data-path $TRAIN_DATA \
    --valid-data-path $VALIDATION_DATA \
    --data-impl mmap \
    --dataloader-type single \
    --num-workers 0 \
    "
c="fe"
BIND_MASK_1="0x${c}000000000000,0x${c}00000000000000,0x${c}0000,0x${c}000000,0x${c},0x${c}00,0x${c}00000000,0x${c}0000000000"
BIND_MASK="$BIND_MASK_1"
echo "Using --cpu-bind=mask_cpu:$BIND_MASK"
mkdir -p pythonuserbase
export PYTHONUSERBASE=pythonuserbase
echo $CMD
echo "START $SLURM_JOBID: $(date)"
if [ ! -d "$wd"/cray-deps ] ; then
  rm -rf "$wd"/cray-deps
  mkdir "$wd"/cray-deps
  cp /usr/lib64/libcxi* $wd/cray-deps
fi
srun \
    --label \
    --cpu-bind=mask_cpu:$BIND_MASK \
    singularity exec \
    -B /opt/cray:/opt/cray \
    -B "$wd"/cray-deps:/opt/cray-deps \
    -B "$wd":/workdir \
    -B "$SING_BIND" \
    -B "$PWD" \
    "$CONTAINER" \
    ./launch.sh \
    $CMD
echo "END $SLURM_JOBID: $(date)"
