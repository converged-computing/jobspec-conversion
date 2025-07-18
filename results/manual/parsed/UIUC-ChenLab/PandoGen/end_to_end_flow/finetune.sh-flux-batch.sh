#!/bin/bash
#FLUX: --job-name=JOBNAME_finetune_sda
#FLUX: -t=86400
#FLUX: --urgency=16

<GPU4_CONFIG>
<ENV_LOAD>
set -e -x -o pipefail
HEAD_SIZE=128
N_HEADS=12
ATTN_SIZE=$((HEAD_SIZE * N_HEADS))
FC_SIZE=$((ATTN_SIZE * 3))
SCRIPTPATH=<SCRIPTPATH>
WORKDIR=<WORKDIR>
train=<TRAIN>
val=<VAL>
python $WORKDIR/load_fa.py $train
python $WORKDIR/load_fa.py $val
N_EXAMPLES=$(cat $train | grep ">" | wc -l)
UPDATE_SIZE=8
BATCH_SIZE=<FINETUNE_BATCH_SIZE>
N_ACC=$((UPDATE_SIZE / BATCH_SIZE))
if [ $N_ACC -eq 0 ]; then
        N_ACC=1
fi
N_GPUS=4
TOTAL_ITERS=61000  # Based on the first training
N_EPOCHS=$(python $WORKDIR/calc_epoch_count.py $TOTAL_ITERS $N_EXAMPLES $BATCH_SIZE $N_ACC $N_GPUS)  # 24
N_ITER=$((N_EXAMPLES * N_EPOCHS / BATCH_SIZE / N_ACC / N_GPUS))
SAVE_STEPS=$((N_ITER / $N_EPOCHS / 2))
ckpt=<PRETRAINED>
Timestamp=<Timestamp>
master_port=$(shuf -i 20000-30000 -n 1)
torchrun --nproc_per_node $N_GPUS --master_port $master_port \
$SCRIPTPATH/train_decoder.py \
        --train $train \
        --val $val \
        --output_dir $WORKDIR/models/sda_JOBNAME_${Timestamp} \
        --do_train \
        --per_device_train_batch_size $BATCH_SIZE \
        --gradient_accumulation_steps $N_ACC \
        --learning_rate 1e-5 \
        --num_train_epochs $N_EPOCHS \
        --lr_scheduler_type linear \
        --warmup_steps 1024 \
        --weight_decay 1e-2 \
        --log_level info \
        --logging_dir $WORKDIR/logs/sda_JOBNAME_logs_${Timestamp} \
        --logging_strategy steps \
        --logging_first_step  \
        --logging_steps 16 \
        --save_strategy steps \
        --save_steps $SAVE_STEPS \
        --evaluation_strategy steps \
        --eval_steps $SAVE_STEPS \
        --fp16 \
        --dataloader_num_workers 0 \
        --intermediate_size $FC_SIZE \
        --hidden_size $ATTN_SIZE \
        --num_hidden_layers 8 \
        --num_attention_heads $N_HEADS \
        --max_position_embeddings 1400 \
        --checkpoint_params $ckpt \
        --checkpoint_model_type "Decoder" \
        --num_quark_quantiles 11 \
        --load_best_model_at_end \
        --save_total_limit 2
