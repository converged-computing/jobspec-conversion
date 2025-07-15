#!/bin/bash
#FLUX: --job-name=chocolate-frito-6737
#FLUX: --priority=16

module load nvidia/cuda/10.0
module load anaconda/3.7
source activate python37
python run_mlm.py \
    --model_name_or_path ../pre_ckpts/my_mengzi_5 \
    --output_dir ../pre_ckpts/my_mengzi_6 \
    --train_file datasets/split_data/mlm/mlm_train.txt \
    --validation_file datasets/split_data/mlm/mlm_dev.txt \
    --per_device_train_batch_size 16 \
    --per_device_eval_batch_size 64 \
    --do_train \
    --do_eval \
    --num_train_epochs 1 \
    --line_by_line \
    --overwrite_output_dir \
    --max_seq_length 32 \
    --weight_decay 0.01 \
    --save_total_limit 1
