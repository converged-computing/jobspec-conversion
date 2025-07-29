#!/bin/bash
#FLUX: --job-name=BertTok
#FLUX: -n=32
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

export OMP_NUM_THREADS='10'
export CUDA_LAUNCH_BLOCKING='1'
export NCCL_ASYNC_ERROR_HANDLING='1'

module purge
module load pytorch-gpu/py3/1.12.1
set -x -e
export OMP_NUM_THREADS=10
export CUDA_LAUNCH_BLOCKING=1
export NCCL_ASYNC_ERROR_HANDLING=1
tokenizer_in=$1
dataset_tokenized_in=$2
model_out=$3
logs_out=$4
mkdir -p "${model_out}"
chmod -R 777 "${model_out}"
mkdir -p "${logs_out}"
chmod -R 777 "${logs_out}"
echo "${tokenizer_in}"
echo "${dataset_tokenized_in}"
echo "${model_out}"
echo "${logs_out}"
srun -l python -u run_training_roberta_v1.py \
    --model_type='camembert' \
    --config_overrides="max_position_embeddings=514,type_vocab_size=1,vocab_size=32000,bos_token_id=0,pad_token_id=1,eos_token_id=2" \
    --tokenizer_name="${tokenizer_in}" \
    --path_load_dataset="${dataset_tokenized_in}" \
    --output_dir="${model_out}" \
    --logging_dir="${logs_out}" \
    --per_device_train_batch_size=32 \
    --do_train \
    --warmup_steps=10000 \
    --overwrite_output_dir \
    --max_seq_length=512 \
    --logging_steps=500 \
    --report_to='tensorboard' \
    --save_strategy='epoch' \
    --skip_memory_metrics='False' \
    --log_level='info' \
    --logging_first_step='True' \
    --num_train_epochs=400 \
    --fp16 \
    --save_total_limit=400 \
    --ddp_timeout=600 \
    --ddp_find_unused_parameters='False' \
