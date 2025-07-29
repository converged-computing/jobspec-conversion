#!/bin/bash
#FLUX: --job-name=alpaca
#FLUX: -n=10
#FLUX: -c=3
#FLUX: --queue=a800
#FLUX: --urgency=16

singularity run --nv \
--pwd /workspace/stanford_alpaca/ \
-B /data/hpc/home/guodong.li/:/workspaces:rw  \
pytorch-alpaca.sif \
torchrun --nproc_per_node=8 --master_port=25001 train.py \
--model_name_or_path /workspaces/llama-7b \
--data_path /workspaces/alpaca_data_cleaned.json \
--output_dir /workspaces/output \
--bf16 True \
--max_steps 100 \
--per_device_train_batch_size 1 \
--per_device_eval_batch_size 1 \
--gradient_accumulation_steps 2 \
--evaluation_strategy "no" \
--save_strategy "steps" \
--save_steps 2000 \
--save_total_limit 1 \
--learning_rate 2e-5 \
--weight_decay 0. \
--warmup_ratio 0.03 \
--lr_scheduler_type "cosine" \
--logging_steps 1 \
--report_to "tensorboard" \
--fsdp "full_shard auto_wrap" \
--fsdp_transformer_layer_cls_to_wrap 'LlamaDecoderLayer' \
--tf32 True
