#!/bin/bash
#FLUX: --job-name=fugly-sundae-3457
#FLUX: --exclusive
#FLUX: --priority=16

set -eux
readonly docker_image="nvcr.io/nvidia/pytorch:20.06-py3"
readonly datadir="/raid/datasets/bert/hdf5/shard_1472_test_split_10/seq_128_pred_20_dupe_5/training"
readonly datadir_phase2="/raid/datasets/bert/hdf5/shard_1472_test_split_10/seq_512_pred_80_dupe_5/training"
readonly checkpointdir="$PWD/checkpoints"
readonly mounts=".:/workspace/bert,${datadir}:/workspace/data,${datadir_phase2}:/workspace/data_phase2,${checkpointdir}:/results"
BIND_CMD="./bind.sh --cpu=exclusive --ib=single --"
srun --ntasks="${SLURM_JOB_NUM_NODES}" --ntasks-per-node=1 mkdir -p "${checkpointdir}"
PHASE1="\
    --train_batch_size=${BATCHSIZE:-16} \
    --learning_rate=${LR:-6e-3} \
    --warmup_proportion=${WARMUP_UPDATES:-0.2843} \
    --input_dir=/workspace/data \
    --max_seq_length=128 \
    --max_predictions_per_seq=20 \
    --max_steps=7038 \
    --num_steps_per_checkpoint=2500 \
    "
PHASE2="\
    --train_batch_size=${BATCHSIZE:-4096} \
    --learning_rate=${LR:-4e-3} \
    --warmup_proportion=${WARMUP_UPDATES:-0.128} \
    --input_dir=/workspace/data_phase2 \
    --phase2 \
    --max_seq_length=512 \
    --max_predictions_per_seq=80 \
    --max_steps=1563 \
    --num_steps_per_checkpoint=1000 \
    --resume_from_checkpoint --phase1_end_step=7038 \
    "
PHASES=( "$PHASE1" "$PHASE2" ) 
PHASE=${PHASE:-1}
BERT_CMD="\
    ${BIND_CMD} python -u /workspace/bert/run_pretraining.py \
    --seed=42 \
    ${PHASES[$((PHASE-1))]} \
    --do_train \
    --config_file=/workspace/bert/bert_config.json \
    --output_dir=/results \
    --fp16 \
    --allreduce_post_accumulation --allreduce_post_accumulation_fp16 \
    --gradient_accumulation_steps=${GRADIENT_STEPS:-2} \
    --log_freq=1 \
    --local_rank=\${SLURM_LOCALID}"
srun -l --container-image="${docker_image}" --container-mounts="${mounts}" sh -c "${BERT_CMD}"
