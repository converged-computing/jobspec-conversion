#!/bin/bash
#FLUX: --job-name=goodbye-omelette-2762
#FLUX: --queue=condo
#FLUX: -t=41400
#FLUX: --urgency=16

export DATA_DIR='/scratch/ba63/magold_files/EGY'
export MAX_LENGTH='512'
export BERT_MODEL='/scratch/nlp/CAMeLBERT/model/bert-base-wp-30k_msl-512-MSA-full-1000000-step'
export OUTPUT_DIR='/scratch/ba63/fine_tuned_models/pos_models/EGY/CAMeLBERT_MSA_POS_EGY'
export BATCH_SIZE='32'
export NUM_EPOCHS='10'
export SAVE_STEPS='500'
export SEED='12345'

nvidia-smi
module purge
export DATA_DIR=/scratch/ba63/magold_files/EGY
export MAX_LENGTH=512
export BERT_MODEL=/scratch/nlp/CAMeLBERT/model/bert-base-wp-30k_msl-512-MSA-full-1000000-step
export OUTPUT_DIR=/scratch/ba63/fine_tuned_models/pos_models/EGY/CAMeLBERT_MSA_POS_EGY
export BATCH_SIZE=32
export NUM_EPOCHS=10
export SAVE_STEPS=500
export SEED=12345
python run_token_classification.py \
--data_dir $DATA_DIR \
--task_type pos \
--labels $DATA_DIR/labels.txt \
--model_name_or_path $BERT_MODEL \
--output_dir $OUTPUT_DIR \
--max_seq_length  $MAX_LENGTH \
--num_train_epochs $NUM_EPOCHS \
--per_device_train_batch_size $BATCH_SIZE \
--save_steps $SAVE_STEPS \
--seed $SEED \
--overwrite_output_dir \
--overwrite_cache \
--do_train \
--do_eval
