#!/bin/bash
#FLUX: --job-name=joyous-poo-0511
#FLUX: -t=172740
#FLUX: --urgency=16

export DATA_DIR='/home/ba63/gec-release/data/ged/qalb14/w_camelira/binary'
export BERT_MODEL='/scratch/ba63/BERT_models/bert-base-arabic-camelbert-msa'
export OUTPUT_DIR='/scratch/ba63/gec-release/models/ged/qalb14/w_camelira/binary'
export BATCH_SIZE='32'
export NUM_EPOCHS='10'
export SAVE_STEPS='500'
export SEED='42'

nvidia-smi
module purge
export DATA_DIR=/home/ba63/gec-release/data/ged/qalb14/w_camelira/binary
export BERT_MODEL=/scratch/ba63/BERT_models/bert-base-arabic-camelbert-msa
export OUTPUT_DIR=/scratch/ba63/gec-release/models/ged/qalb14/w_camelira/binary
export BATCH_SIZE=32
export NUM_EPOCHS=10
export SAVE_STEPS=500
export SEED=42
python error_detection.py \
    --data_dir $DATA_DIR \
    --optim adamw_torch \
    --labels $DATA_DIR/labels.txt \
    --model_name_or_path $BERT_MODEL \
    --output_dir $OUTPUT_DIR \
    --num_train_epochs $NUM_EPOCHS \
    --per_device_train_batch_size $BATCH_SIZE \
    --save_steps $SAVE_STEPS \
    --seed $SEED \
    --do_train \
    --overwrite_output_dir
