#!/bin/bash
#FLUX: --job-name=bloated-peanut-butter-6515
#FLUX: -c=10
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/opt/conda/lib/' '

module purge
module load anaconda
module load cuda/11.4.2
source activate falcon_40B
conda install -n falcon_40B python-dotenv
pip install -U -r requirements.txt
conda install -y cudatoolkit
export LD_LIBRARY_PATH='/opt/conda/lib/' 
python qlora_mammoth.py \
    --model_name_or_path TIGER-Lab/MAmmoTH-70B \
    --output_dir ./mammoth_QA_adapter \
    --logging_steps 10 \
    --save_strategy steps \
    --data_seed 42 \
    --save_steps 250 \
    --save_total_limit 40 \
    --evaluation_strategy steps \
    --eval_dataset_size 2000 \
    --max_eval_samples 1000 \
    --per_device_eval_batch_size 1 \
    --max_new_tokens 400 \
    --dataloader_num_workers 3 \
    --group_by_length \
    --logging_strategy steps \
    --remove_unused_columns False \
    --do_train \
    --do_eval \
    --lora_r 64 \
    --lora_alpha 16 \
    --lora_modules all \
    --double_quant \
    --quant_type nf4 \
    --bf16 \
    --bits 4 \
    --warmup_ratio 0.03 \
    --lr_scheduler_type constant \
    --gradient_checkpointing \
    --dataset="mammoth_train.json" \
    --source_max_len 16 \
    --target_max_len 512 \
    --per_device_train_batch_size 1 \
    --gradient_accumulation_steps 16 \
    --max_steps 5000 \
    --eval_steps 187 \
    --learning_rate 0.0001 \
    --adam_beta2 0.999 \
    --max_grad_norm 0.3 \
    --lora_dropout 0.05 \
    --weight_decay 0.0 \
    --seed 0
