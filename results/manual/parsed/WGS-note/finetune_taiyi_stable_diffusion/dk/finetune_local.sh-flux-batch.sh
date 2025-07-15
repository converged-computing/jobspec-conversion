#!/bin/bash
#FLUX: --job-name=finetune_taiyi
#FLUX: -c=30
#FLUX: --urgency=16

export options=' \'

cd /Users/wangguisen/Documents/markdowns/AI-note/元宇宙
MODEL_NAME=Taiyi-Stable-Diffusion-1B-Chinese-v0.1
MODEL_ROOT_DIR=/Users/wangguisen/Documents/markdowns/AI-note/元宇宙/pre_models/${MODEL_NAME}
NNODES=1
GPUS_PER_NODE=1
MICRO_BATCH_SIZE=1
DATA_ARGS="\
        --dataloader_workers 2 \
        --train_batchsize $MICRO_BATCH_SIZE  \
        --val_batchsize $MICRO_BATCH_SIZE \
        --test_batchsize $MICRO_BATCH_SIZE  \
        --datasets_path /Users/wangguisen/Documents/markdowns/AI-note/元宇宙/finetune_taiyi_stable_diffusion/demo_dataset \
        --datasets_type txt \
        --resolution 512 \
        "
MODEL_ARGS="\
        --model_path /Users/wangguisen/Documents/markdowns/AI-note/元宇宙/pre_models/Taiyi-Stable-Diffusion-1B-Chinese-v0.1 \
        --learning_rate 1e-4 \
        --weight_decay 1e-1 \
        --warmup_ratio 0.01 \
        "
MODEL_CHECKPOINT_ARGS="\
        --save_last \
        --save_ckpt_path ${MODEL_ROOT_DIR}/ckpt \
        --load_ckpt_path ${MODEL_ROOT_DIR}/ckpt/last.ckpt \
        "
TRAINER_ARGS="\
        --max_epoch 10 \
        --gpus $GPUS_PER_NODE \
        --num_nodes $NNODES \
        --strategy deepspeed_stage_${ZERO_STAGE} \
        --log_every_n_steps 100 \
        --precision 32 \
        --default_root_dir ${MODEL_ROOT_DIR} \
        --replace_sampler_ddp False \
        --num_sanity_val_steps 0 \
        --limit_val_batches 0 \
        "
export options=" \
        $DATA_ARGS \
        $MODEL_ARGS \
        $MODEL_CHECKPOINT_ARGS \
        $TRAINER_ARGS \
        "
cd ./finetune_taiyi_stable_diffusion
python -u ./finetune.py $options 1>>./finetune.log 2>>./finetune.err
