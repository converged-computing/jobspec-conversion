#!/bin/bash
#FLUX: --job-name=mmlu
#FLUX: -N=8
#FLUX: -c=10
#FLUX: --queue=learnlab
#FLUX: -t=28800
#FLUX: --urgency=16

size=xl
DATA_DIR='/checkpoint/plewis/atlas_opensourcing/'
port=$(shuf -i 15000-16000 -n 1)
EVAL_FILES="${DATA_DIR}/data/mmlu_data/5-shot-multitask/combined_valid.jsonl ${DATA_DIR}/data/mmlu_data/5-shot-multitask/combined_test.jsonl"
PRETRAINED_MODEL=${DATA_DIR}/models/atlas/${size}
PRETRAINED_INDEX=${DATA_DIR}/indices/atlas/wiki/${size}
SAVE_DIR=${DATA_DIR}/experiments/
EXPERIMENT_NAME=$SLURM_JOB_ID-${size}-mmlu-zeroshot
PRECISION="fp32" # "bf16"
srun python evaluate.py \
    --precision ${PRECISION} \
    --target_maxlength 16 \
    --reader_model_type google/t5-${size}-lm-adapt \
    --text_maxlength 512 \
    --model_path ${PRETRAINED_MODEL} \
    --eval_data ${EVAL_FILES} \
    --per_gpu_batch_size 1 \
    --n_context 30 --retriever_n_context 30 \
    --name ${EXPERIMENT_NAME} \
    --checkpoint_dir ${SAVE_DIR} \
    --main_port $port \
    --write_results \
    --task multiple_choice \
    --multiple_choice_train_permutations all\
    --multiple_choice_eval_permutations cyclic\
    --index_mode flat \
    --load_index_path ${PRETRAINED_INDEX}
