#!/bin/bash
#FLUX: --job-name=deepspeed-llama7b-1gpu
#FLUX: -c=4
#FLUX: --queue=clara
#FLUX: --urgency=16

export GPUS_PER_NODE='1'
export MASTER_ADDR='$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)'
export MASTER_PORT='9906'

module load Python
module load PyTorch
srun pip install --user -r requirements.txt
srun pip install --user git+https://github.com/huggingface/transformers
export GPUS_PER_NODE=1
export MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export MASTER_PORT=9906
MODEL_PATH=./llama_models/7B
USE_FAST_TOKENIZER=true
TORCH_DTYPE=auto
LOW_CPU_MEM_USAGE=true
TRAIN_FILE=./input/health_information_systems_epub.md
MAX_TRAIN_SAMPLES=1000
VALIDATION_SPLIT_PERCENTAGE=5
PREPROCESSING_NUM_WORKERS=1
KEEP_LINEBREAKS=true
OUTPUT_DIR=./trained/7B
OVERWRITE_OUTPUT_DIR=false
DO_TRAIN=true
DO_EVAL=true
EVALUATION_STRATEGY=steps
EVAL_STEPS=100
LEARNING_RATE=3e-4
WEIGHT_DECAY=0.1
ADAM_BETA1=0.9
ADAM_BETA2=0.95
ADAM_EPSILON=1e-8
MAX_GRAD_NORM=1.0
NUM_TRAIN_EPOCHS=3
LR_SCHEDULER_TYPE=cosine
WARMUP_STEPS=0
LOG_LEVEL=passive
SAVE_STRATEGY=steps
SAVE_STEPS=500
SAVE_TOTAL_LIMIT=1
NO_CUDA=false
SEED=42
FP16=true
HALF_PRECISION_BACKEND=auto
DDP_BACKEND=nccl
DEEPSPEED=ds_config.json
OPTIM=adamw_hf
echo "srun --jobid $SLURM_JOBID bash -c \"NCCL_DEBUG=INFO python -m torch.distributed.run "
echo "--nproc_per_node $GPUS_PER_NODE "
echo "--nnodes $SLURM_NNODES "
echo "--node_rank $SLURM_PROCID "
echo "--master_addr $MASTER_ADDR "
echo "--master_port $MASTER_PORT "
echo "03_train_llama.py "
echo "--model_path $MODEL_PATH "
echo "--use_fast_tokenizer $USE_FAST_TOKENIZER "
echo "--torch_dtype $TORCH_DTYPE "
echo "--low_cpu_mem_usage $LOW_CPU_MEM_USAGE "
echo "--train_file $TRAIN_FILE "
echo "--max_train_samples $MAX_TRAIN_SAMPLES "
echo "--validation_split_percentage $VALIDATION_SPLIT_PERCENTAGE "
echo "--preprocessing_num_workers $PREPROCESSING_NUM_WORKERS "
echo "--keep_linebreaks $KEEP_LINEBREAKS "
echo "--output_dir $OUTPUT_DIR "
echo "--overwrite_output_dir $OVERWRITE_OUTPUT_DIR "
echo "--do_train $DO_TRAIN "
echo "--do_eval $DO_EVAL "
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
echo "--half_precision_backend $HALF_PRECISION_BACKEND "
echo "--local_rank $SLURM_PROCID "
echo "--ddp_backend $DDP_BACKEND "
echo "--deepspeed $DEEPSPEED "
echo "--optim $OPTIM\""
srun --jobid $SLURM_JOBID bash -c "NCCL_DEBUG=INFO python -m torch.distributed.run \
--nproc_per_node $GPUS_PER_NODE \
--nnodes $SLURM_NNODES \
--node_rank $SLURM_PROCID \
--master_addr $MASTER_ADDR \
--master_port $MASTER_PORT \
03_train_llama.py \
--model_path $MODEL_PATH \
--use_fast_tokenizer $USE_FAST_TOKENIZER \
--torch_dtype $TORCH_DTYPE \
--low_cpu_mem_usage $LOW_CPU_MEM_USAGE \
--train_file $TRAIN_FILE \
--max_train_samples $MAX_TRAIN_SAMPLES \
--validation_split_percentage $VALIDATION_SPLIT_PERCENTAGE \
--preprocessing_num_workers $PREPROCESSING_NUM_WORKERS \
--keep_linebreaks $KEEP_LINEBREAKS \
--output_dir $OUTPUT_DIR \
--overwrite_output_dir $OVERWRITE_OUTPUT_DIR \
--do_train $DO_TRAIN \
--do_eval $DO_EVAL \
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
--half_precision_backend $HALF_PRECISION_BACKEND \
--local_rank $SLURM_PROCID \
--ddp_backend $DDP_BACKEND \
--deepspeed $DEEPSPEED \
--optim $OPTIM"
