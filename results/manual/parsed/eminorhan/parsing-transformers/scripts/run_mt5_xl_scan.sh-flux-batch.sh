#!/bin/bash
#FLUX: --job-name=mt5_xl_scan
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load cuda/11.1.74
SPLIT=right # add_jump, add_turn_left, around_right, jump_around_right, length, opposite_right, right
EPOCHS=12 
python -u /scratch/eo41/parsing-transformers/run_translation.py \
    --benchmark SCAN \
    --use_pretrained_weights True \
    --model_name_or_path google/mt5-xl \
    --output_dir out_mt5_xl_${SPLIT}_${EPOCHS}_$SLURM_ARRAY_TASK_ID \
    --train_file data_scan/$SPLIT/train.json \
    --test_file data_scan/$SPLIT/test.json \
    --do_train \
    --do_predict \
    --source_lang en \
    --target_lang en \
    --per_device_train_batch_size 16 \
    --per_device_eval_batch_size 8 \
    --num_train_epochs $EPOCHS \
    --seed $SLURM_ARRAY_TASK_ID \
    --overwrite_output_dir \
    --save_steps 2500000000 \
    --max_target_length 512 \
    --max_source_length 512 \
    --predict_with_generate \
    --model_parallel
echo "Done"
