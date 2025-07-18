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
TRAIN_FILE="${DATA_DIR}/data/mmlu_data/full/train.jsonl"
EVAL_FILES="${DATA_DIR}/data/mmlu_data/full/combined_valid.jsonl ${DATA_DIR}/data/mmlu_data/full/combined_test.jsonl"
PRETRAINED_MODEL=${DATA_DIR}/models/atlas/${size}
PRETRAINED_INDEX=${DATA_DIR}/indices/atlas/wiki/${size}
SAVE_DIR=${DATA_DIR}/experiments/
EXPERIMENT_NAME=$SLURM_JOB_ID-${size}-mmlu-full
PRECISION="fp32" # "bf16" if available!
srun python train.py \
    --shuffle \
    --train_retriever --gold_score_mode ppmean \
    --use_gradient_checkpoint_reader \
    --use_gradient_checkpoint_retriever\
    --precision ${PRECISION} \
    --shard_optim --shard_grads \
    --temperature_gold 0.1 --temperature_score 0.1 \
    --refresh_index 100000000000 \
    --target_maxlength 16 \
    --reader_model_type google/t5-${size}-lm-adapt \
    --dropout 0.1 \
    --lr 5e-5 --lr_retriever 1e-5 \
    --scheduler linear \
    --weight_decay 0.01 \
    --text_maxlength 512 \
    --model_path ${PRETRAINED_MODEL} \
    --train_data ${TRAIN_FILE} \
    --eval_data ${EVAL_FILES} \
    --per_gpu_batch_size 1 \
    --n_context 30 --retriever_n_context 30 \
    --name ${EXPERIMENT_NAME} \
    --checkpoint_dir ${SAVE_DIR} \
    --eval_freq 150 \
    --log_freq 4 \
    --total_steps 2000 \
    --warmup_steps 50 \
    --save_freq 10000000000 \
    --main_port $port \
    --write_results \
    --task multiple_choice \
    --multiple_choice_train_permutations all\
    --multiple_choice_eval_permutations cyclic\
    --index_mode flat \
    --query_side_retriever_training \
    --load_index_path ${PRETRAINED_INDEX}
