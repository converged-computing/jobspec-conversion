#!/bin/bash
#FLUX: --job-name=webclip
#FLUX: -c=12
#FLUX: -t=0
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate webclip
python run.py \
    --base_model google/vit-base-patch32-384 \
    --output_model_path ./models/vit-base-patch32-384-clueweb-screenshots-inlink-5epoch-minmax-384 \
    --logging_steps 1 \
    --eval_steps 60 \
    --per_device_train_batch_size 128 \
    --per_device_eval_batch_size 500 \
    --gradient_accumulation_steps 1 \
    --learning_rate 1e-5 \
    --epochs 5 \
    --warmup_steps 10
