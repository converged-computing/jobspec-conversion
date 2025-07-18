#!/bin/bash
#FLUX: --job-name=llama2-7b-2gpu
#FLUX: -c=8
#FLUX: --queue=clara
#FLUX: -t=172800
#FLUX: --urgency=16

export GPUS_PER_NODE='2'
export MASTER_ADDR='$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)'
export MASTER_PORT='9907'
export NCCL_DEBUG='INFO'
export NCCL_IGNORE_DISABLED_P2P='1'

module load Python
module load PyTorch
source .env/bin/activate
srun pip install git+https://github.com/huggingface/transformers
srun pip install typing-extensions
srun pip install datasets
srun pip install torch
srun pip install accelerate
srun pip install pytest
srun pip install scikit-learn
srun pip install evaluate
srun pip install sentencepiece
srun pip install deepspeed
export GPUS_PER_NODE=2
export MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export MASTER_PORT=9907
export NCCL_DEBUG=INFO
export NCCL_IGNORE_DISABLED_P2P=1
MODEL_NAME=meta-llama/Llama-2-7b-hf
CACHE_DIR=./cache
USE_FAST_TOKENIZER=false
MODEL_REVISION=main
USE_AUTH_TOKEN=true
HUGGING_TOKEN=<BLANKED>
TORCH_DTYPE=auto
LOW_CPU_MEM_USAGE=false
TRAIN_FILE=./input/health_information_systems_epub.md
MAX_TRAIN_SAMPLES=None
OVERWRITE_CACHE=false
VALIDATION_SPLIT_PERCENTAGE=5
PREPROCESSING_NUM_WORKERS=1
KEEP_LINEBREAKS=true
OUTPUT_DIR=./trained/7B-8
OVERWRITE_OUTPUT_DIR=true
DO_TRAIN=true
DO_EVAL=true
PER_DEVICE_TRAIN_BATCH_SIZE=1
PER_DEVICE_EVAL_BATCH_SIZE=1
BLOCK_SIZE=1024
EVALUATION_STRATEGY=steps
EVAL_STEPS=50
LEARNING_RATE=3e-4
WEIGHT_DECAY=0.1
ADAM_BETA1=0.9
ADAM_BETA2=0.95
ADAM_EPSILON=1e-5
MAX_GRAD_NORM=1.0
NUM_TRAIN_EPOCHS=8
LR_SCHEDULER_TYPE=cosine
WARMUP_STEPS=0
LOG_LEVEL=passive
SAVE_STRATEGY=steps
SAVE_STEPS=100
SAVE_TOTAL_LIMIT=1
NO_CUDA=false
SEED=42
FP16=true
BF16=false
HALF_PRECISION_BACKEND=auto
DDP_BACKEND=nccl
DEEPSPEED=./ds_configs/stage2_offload.json
OPTIM=adamw_torch
echo "srun --jobid $SLURM_JOBID bash -c \"NCCL_DEBUG=INFO deepspeed "
echo "--num_gpus=$GPUS_PER_NODE "
echo "03_train_llama2.py "
echo "--model_name $MODEL_NAME "
echo "--cache_dir $CACHE_DIR "
echo "--use_fast_tokenizer $USE_FAST_TOKENIZER "
echo "--model_revision $MODEL_REVISION "
echo "--use_auth_token $USE_AUTH_TOKEN "
echo "--hugging_token $HUGGING_TOKEN "
echo "--torch_dtype $TORCH_DTYPE "
echo "--low_cpu_mem_usage $LOW_CPU_MEM_USAGE "
echo "--train_file $TRAIN_FILE "
echo "--overwrite_cache $OVERWRITE_CACHE "
echo "--validation_split_percentage $VALIDATION_SPLIT_PERCENTAGE "
echo "--preprocessing_num_workers $PREPROCESSING_NUM_WORKERS "
echo "--keep_linebreaks $KEEP_LINEBREAKS "
echo "--output_dir $OUTPUT_DIR "
echo "--overwrite_output_dir $OVERWRITE_OUTPUT_DIR "
echo "--do_train $DO_TRAIN "
echo "--do_eval $DO_EVAL "
echo "--per_device_train_batch_size $PER_DEVICE_TRAIN_BATCH_SIZE "
echo "--per_device_eval_batch_size $PER_DEVICE_EVAL_BATCH_SIZE "
echo "--block_size $BLOCK_SIZE "
echo "--evaluation_strategy $EVALUATION_STRATEGY "
echo "--eval_steps $EVAL_STEPS "
echo "--learning_rate $LEARNING_RATE "
echo "--weight_decay $WEIGHT_DECAY "
echo "--adam_beta1 $ADAM_BETA1 "
echo "--adam_beta2 $ADAM_BETA2 "
echo "--adam_epsilon $ADAM_EPSILON "
echo "--max_grad_norm $MAX_GRAD_NORM "
echo "--num_train_epochs $NUM_TRAIN_EPOCHS "
echo "--lr_scheduler_type $LR_SCHEDULER_TYPE "
echo "--warmup_steps $WARMUP_STEPS "
echo "--log_level $LOG_LEVEL "
echo "--save_strategy $SAVE_STRATEGY "
echo "--save_steps $SAVE_STEPS "
echo "--save_total_limit $SAVE_TOTAL_LIMIT "
echo "--no_cuda $NO_CUDA "
echo "--seed $SEED "
echo "--fp16 $FP16 "
echo "--bf16 $BF16 "
echo "--half_precision_backend $HALF_PRECISION_BACKEND "
echo "--local_rank $SLURM_PROCID "
echo "--ddp_backend $DDP_BACKEND "
echo "--deepspeed $DEEPSPEED "
echo "--optim $OPTIM\""
srun --jobid $SLURM_JOBID bash -c "NCCL_DEBUG=INFO deepspeed \
--num_gpus=$GPUS_PER_NODE \
03_train_llama2.py \
--model_name $MODEL_NAME \
--cache_dir $CACHE_DIR \
--use_fast_tokenizer $USE_FAST_TOKENIZER \
--model_revision $MODEL_REVISION \
--use_auth_token $USE_AUTH_TOKEN \
--hugging_token $HUGGING_TOKEN \
--torch_dtype $TORCH_DTYPE \
--low_cpu_mem_usage $LOW_CPU_MEM_USAGE \
--train_file $TRAIN_FILE \
--overwrite_cache $OVERWRITE_CACHE \
--validation_split_percentage $VALIDATION_SPLIT_PERCENTAGE \
--preprocessing_num_workers $PREPROCESSING_NUM_WORKERS \
--keep_linebreaks $KEEP_LINEBREAKS \
--output_dir $OUTPUT_DIR \
--overwrite_output_dir $OVERWRITE_OUTPUT_DIR \
--do_train $DO_TRAIN \
--do_eval $DO_EVAL \
--per_device_train_batch_size $PER_DEVICE_TRAIN_BATCH_SIZE \
--per_device_eval_batch_size $PER_DEVICE_EVAL_BATCH_SIZE \
--block_size $BLOCK_SIZE \
--evaluation_strategy $EVALUATION_STRATEGY \
--eval_steps $EVAL_STEPS \
--learning_rate $LEARNING_RATE \
--weight_decay $WEIGHT_DECAY \
--adam_beta1 $ADAM_BETA1 \
--adam_beta2 $ADAM_BETA2 \
--adam_epsilon $ADAM_EPSILON \
--max_grad_norm $MAX_GRAD_NORM \
--num_train_epochs $NUM_TRAIN_EPOCHS \
--lr_scheduler_type $LR_SCHEDULER_TYPE \
--warmup_steps $WARMUP_STEPS \
--log_level $LOG_LEVEL \
--save_strategy $SAVE_STRATEGY \
--save_steps $SAVE_STEPS \
--save_total_limit $SAVE_TOTAL_LIMIT \
--no_cuda $NO_CUDA \
--seed $SEED \
--fp16 $FP16 \
--bf16 $BF16 \
--half_precision_backend $HALF_PRECISION_BACKEND \
--local_rank $SLURM_PROCID \
--ddp_backend $DDP_BACKEND \
--optim $OPTIM \
--deepspeed $DEEPSPEED "
