#!/bin/bash
#FLUX: --job-name=mlm_drbert
#FLUX: -n=128
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
srun -l python -u run_train_jeanzay.py \
    --model_type='camembert' \
    --config_overrides="max_position_embeddings=514,type_vocab_size=1,vocab_size=32005,bos_token_id=5,eos_token_id=6" \
    --tokenizer_name='./Tokenizer/' \
    --path_load_dataset="./data/tokenized_dataset" \
    --output_dir='./Model_output/' \
    --logging_dir='./Model_output/logs/' \
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
