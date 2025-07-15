#!/bin/bash
#FLUX: --job-name=chocolate-noodle-7506
#FLUX: -t=41400
#FLUX: --urgency=16

export DATA_DIR='ANERCorp-CamelLabSplits/'
export MAX_LENGTH='512'
export BERT_MODEL='/scratch/nlp/CAMeLBERT/model/bert-base-wp-30k_msl-512-MSA-sixteenth-1000000-step'
export OUTPUT_DIR='/scratch/ba63/fine_tuned_models/ner_models/CAMeLBERT_MSA_sixteenth_NER'
export BATCH_SIZE='32'
export NUM_EPOCHS='3'
export SAVE_STEPS='750'
export SEED='12345'

nvidia-smi
module purge
export DATA_DIR=ANERCorp-CamelLabSplits/
export MAX_LENGTH=512
export BERT_MODEL=/scratch/nlp/CAMeLBERT/model/bert-base-wp-30k_msl-512-MSA-sixteenth-1000000-step
export OUTPUT_DIR=/scratch/ba63/fine_tuned_models/ner_models/CAMeLBERT_MSA_sixteenth_NER
export BATCH_SIZE=32
export NUM_EPOCHS=3
export SAVE_STEPS=750
export SEED=12345
python run_token_classification.py \
--data_dir $DATA_DIR \
--task_type ner \
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
--do_predict
