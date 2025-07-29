#!/bin/bash
#SBATCH --job-name=mlm_cont
#SBATCH --output=mlm_test%j.out
#SBATCH --error=mlm_test%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=20:00:00
#SBATCH --constraint=v100-32g,ntasks-per-node=4

export OMP_NUM_THREADS='10'
export CUDA_LAUNCH_BLOCKING='1'
export NCCL_ASYNC_ERROR_HANDLING='1'

module purge
module load pytorch-gpu/py3/1.12.1
set -x -e
export OMP_NUM_THREADS=10
export CUDA_LAUNCH_BLOCKING=1
export NCCL_ASYNC_ERROR_HANDLING=1
srun -l python -u run_training.py \
    --model_name_or_path='../data/camembert_base_hf' \
    --tokenizer_name='../data/camembert_base_hf' \
    --path_load_dataset="../data/tokenized_dataset" \
    --output_dir='./Model_out/' \
    --logging_dir='./Model_out/logs/' \
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
