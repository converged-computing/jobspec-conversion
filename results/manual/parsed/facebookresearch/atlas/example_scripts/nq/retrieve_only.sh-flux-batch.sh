#!/bin/bash
#FLUX: --job-name=nq
#FLUX: -N=4
#FLUX: -c=10
#FLUX: --queue=devlab
#FLUX: -t=14400
#FLUX: --priority=16

size=xl
DATA_DIR='/checkpoint/plewis/atlas_opensourcing_check/'
port=$(shuf -i 15000-16000 -n 1)
PASSAGES_TO_RETRIEVE_FROM="${DATA_DIR}/corpora/wiki/enwiki-dec2018/text-list-100-sec.jsonl ${DATA_DIR}/corpora/wiki/enwiki-dec2018/infobox.jsonl"
EVAL_FILES="${DATA_DIR}/data/nq_data/dev.jsonl ${DATA_DIR}/data/nq_data/test.jsonl" # run retreival for the Natural Questions dev and test data
PRETRAINED_MODEL=${DATA_DIR}/models/atlas_nq/${size}
SAVE_DIR=${DATA_DIR}/experiments/
EXPERIMENT_NAME=$SLURM_JOB_ID-${size}-nq-retrieve-only
srun python evaluate.py \
    --name ${EXPERIMENT_NAME} \
    --reader_model_type google/t5-${size}-lm-adapt \
    --text_maxlength 512 \
    --model_path ${PRETRAINED_MODEL} \
    --eval_data ${EVAL_FILES} \
    --n_context 40 --retriever_n_context 40 \
    --checkpoint_dir ${SAVE_DIR} \
    --main_port $port \
    --index_mode "flat" \
    --task "qa" \
    --save_index_path ${SAVE_DIR}/${EXPERIMENT_NAME}/saved_index \
    --write_results \
    --retrieve_only \
    --passages ${PASSAGES_TO_RETRIEVE_FROM}
