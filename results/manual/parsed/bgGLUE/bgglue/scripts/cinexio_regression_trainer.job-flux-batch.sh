#!/bin/bash
#FLUX: --job-name=scruptious-kitty-4762
#FLUX: --urgency=16

export WANDB_TAGS='${MODEL_NAME},${TASK_NAME}'

set -eux
ACTION_STEPS=200
EPOCHS=5
TASK_NAME="cinexio/regression"
OUTPUT_DIR="${HOME_PATH}models/${TASK_NAME}/${MODEL_NAME}/seed_${SEED}/ep_${EPOCHS}_bs_${BATCH_SIZE}_ga_${GRAD_ACC}_lr_${LEARNING_RATE}_seq_${MAX_SEQ_LEN}_warm_${WARMUP}_weight_${WEIGHT_DEC}"
export WANDB_TAGS="${MODEL_NAME},${TASK_NAME}"
if [[ -d "${OUTPUT_DIR}/pytorch_model.bin" ]]; then
  echo "Skipping directory model already exists"
  exit 0
fi
${PYTHON_ENV_PATH}python ${HOME_PATH}src/bg_glue_benchmark/run_cinexio.py \
--model_name_or_path ${MODEL_NAME} \
--dataset_name ${HOME_PATH}src/bg_glue_benchmark/bgdatasets/bgglue \
--dataset_config_name cinexio \
--data_dir ${HOME_PATH}data \
--do_train \
--do_eval \
--do_predict \
--task_type regression \
--load_best_model_at_end \
--metric_for_best_model "sp_correlation" \
--warmup_ratio ${WARMUP} \
--save_strategy steps \
--save_steps ${ACTION_STEPS} \
--logging_strategy steps \
--logging_steps ${ACTION_STEPS} \
--evaluation_strategy steps \
--eval_steps ${ACTION_STEPS} \
--learning_rate ${LEARNING_RATE} \
--num_train_epochs ${EPOCHS} \
--max_seq_length ${MAX_SEQ_LEN} \
--output_dir ${OUTPUT_DIR} \
--weight_decay ${WEIGHT_DEC} \
--per_device_eval_batch_size ${EVAL_BATCH_SIZE} \
--per_device_train_batch_size ${BATCH_SIZE} \
--gradient_accumulation_steps ${GRAD_ACC} \
--seed ${SEED} \
--fp16 \
--overwrite_output \
--overwrite_cache \
--cache_dir ${HOME_PATH}cache \
--save_total_limit 1 \
--report_to wandb \
--pad_to_max_length false
