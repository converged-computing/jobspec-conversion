#!/bin/bash
#FLUX: --job-name=peachy-toaster-7050
#FLUX: --exclusive
#FLUX: --priority=16

set -eux
IMAGE_VERSION=${IMAGE_VERSION:-"21.11-py3"}
DASK_TASKS_PER_NODE=${DASK_TASKS_PER_NODE:-128}
PHASE=${PHASE:-1}
SEED=${SEED:-42}
SAMPLE_RATIO=${SAMPLE_RATIO:-0.9}
STEPS_THIS_RUN=${STEPS_THIS_RUN:-"none"}
GPUS=${GPUS:-"8"}
BIN_SIZE=${BIN_SIZE:-"64"}
NUM_SHARDS_PER_WORKER=${NUM_SHARDS_PER_WORKER:-"none"}
NUM_WORKERS=${NUM_WORKERS:-4}
RERUN_DASK=${RERUN_DASK:-"true"}
MASKING=${MASKING:-"static"}
USE_JEMALLOC=${USE_JEMALLOC:-"true"}
PRECISION=${PRECISION:-"fp16"}
CONFIG=${CONFIG:-"large"}
INIT_CHECKPOINT=${INIT_CHECKPOINT:-"none"}
TRAIN_BATCH_SIZE=${TRAIN_BATCH_SIZE:-"8192"}
GRADIENT_ACCUMULATION_STEPS=${GRADIENT_ACCUMULATION_STEPS:-"32"}
readonly docker_image="bert:${IMAGE_VERSION}" 
readonly host_datadir="/home/${USER}/datasets"
readonly container_datadir="/datasets"
readonly host_wikipedia_source="${host_datadir}/wikipedia/source"
readonly container_wikipedia_source="${container_datadir}/wikipedia/source"
readonly wikipedia_mount="${host_wikipedia_source}:${container_wikipedia_source}"
readonly host_pretrain="${host_datadir}/pretrain"
readonly container_pretrain="${container_datadir}/pretrain"
readonly pretrain_mount="${host_pretrain}:${container_pretrain}"
readonly host_output="$PWD/results/${SLURM_JOB_ID}"
mkdir -p "${host_output}"
readonly container_output="/results"
readonly output_mount="${host_output}:${container_output}"
if [ "${INIT_CHECKPOINT}" == "none" ] && [ "${PHASE}" == "2" ] ; then
  INIT_CHECKPOINT="$PWD/results/${SLURM_JOB_DEPENDENCY}/ckpt_7038.pt"
fi
mounts="${wikipedia_mount},${pretrain_mount},${output_mount}"
if [ "${PHASE}" == "1" ]; then
  echo "No init. mounted for Phase1!"
  readonly container_init_checkpoint=""
elif [ "${PHASE}" == "2" ]; then
  if [ ! -f "${INIT_CHECKPOINT}" ]; then
    echo "No init. checkpoint found for Phase2!"
    exit 1
  else
    mounts="${mounts},$(dirname "${INIT_CHECKPOINT}"):/checkpoints"
    readonly container_init_checkpoint="/checkpoints/$(basename "${INIT_CHECKPOINT}")"
  fi
else
  echo "\${PHASE} = ${PHASE} unknown!"
  exit 1
fi
if [ "${RERUN_DASK}" == "true" ]; then
  # Always rerun the dask pipeline. Therefore, use the output directory to store
  # the parquets.
  readonly host_pretrain_parquet="${host_output}/parquet"
  readonly container_pretrain_parquet="${container_output}/parquet"
elif [ "${RERUN_DASK}" == "false" ]; then
  echo "Use existing parquets if they exists."
  if [ "${BIN_SIZE}" == "none" ]; then
      readonly host_pretrain_parquet="${host_pretrain}/phase${PHASE}/unbinned/parquet"
      readonly container_pretrain_parquet="${container_pretrain}/phase${PHASE}/unbinned/parquet"
  else
      readonly host_pretrain_parquet="${host_pretrain}/phase${PHASE}/bin_size_${BIN_SIZE}/parquet"
      readonly container_pretrain_parquet="${container_pretrain}/phase${PHASE}/bin_size_${BIN_SIZE}/parquet"
  fi
else
  echo "\${RERUN_DASK} = ${RERUN_DASK} unknown!"
  exit 1
fi
if [ "${STEPS_THIS_RUN}" == "none" ]; then
  readonly steps_this_run_flag=""
else
  readonly steps_this_run_flag="--steps_this_run ${STEPS_THIS_RUN}"
fi
readonly BIND_CMD="./bind.sh --cpu=exclusive --ib=single --"
readonly PHASE1="\
    --learning_rate=6e-3 \
    --warmup_proportion=0.2843 \
    --max_seq_length=128 \
    --max_predictions_per_seq=20 \
    --max_steps=7038 \
    --num_steps_per_checkpoint=2500 \
    "
readonly PHASE2="\
    --learning_rate=4e-3 \
    --warmup_proportion=0.128 \
    --phase2 \
    --max_seq_length=512 \
    --max_predictions_per_seq=80 \
    --max_steps=1563 \
    --num_steps_per_checkpoint=1000 \
    --resume_from_checkpoint --phase1_end_step=7038 \
    --init_checkpoint=${container_init_checkpoint} \
    "
if [ "${PRECISION}" == "fp16" ]; then
  readonly fp16_flags="--fp16 --allreduce_post_accumulation_fp16"
elif [ "${PRECISION}" == "tf32" ]; then
  readonly fp16_flags=""
else
  echo "\${PRECISION} = ${PRECISION} unknown!"
  exit 1
fi
readonly PHASES=( "$PHASE1" "$PHASE2" ) 
readonly BERT_CMD="\
    ${BIND_CMD} python -u /workspace/bert/run_pretraining.py \
    --seed=${SEED} \
    --train_batch_size=${TRAIN_BATCH_SIZE} \
    ${PHASES[$((PHASE - 1))]} \
    --do_train \
    --config_file=/workspace/bert/bert_configs/${CONFIG}.json \
    --input_dir=${container_pretrain_parquet} \
    --vocab_file=/workspace/bert/vocab/vocab \
    --output_dir=${container_output} \
    ${fp16_flags} \
    --allreduce_post_accumulation \
    --gradient_accumulation_steps=${GRADIENT_ACCUMULATION_STEPS} \
    --log_freq=1 \
    --json-summary=${container_output}/summary.json \
    --disable_progress_bar \
    --num_workers=${NUM_WORKERS} \
    ${steps_this_run_flag} \
    --local_rank=\${SLURM_LOCALID} "
echo "nodes: ${SLURM_JOB_NUM_NODES}, TRAIN_BATCH_SIZE: ${TRAIN_BATCH_SIZE}, GRADIENT_ACCUMULATION_STEPS: ${GRADIENT_ACCUMULATION_STEPS}"
if [ "${NUM_SHARDS_PER_WORKER}" == "none" ]; then
  readonly num_blocks=4096
else
  readonly num_blocks=$((NUM_SHARDS_PER_WORKER * $(( NUM_WORKERS > 0 ? NUM_WORKERS : 1 )) * SLURM_JOB_NUM_NODES * GPUS))
fi
echo "num_blocks: ${num_blocks}"
if [ ! -d "${host_pretrain_parquet}" ] || [ -z "$(ls -A "${host_pretrain_parquet}")" ]; then
  # The sequence length is 128 for Phase1, but 512 for Phase2.
  if [ "${PHASE}" == "1" ]; then
    readonly target_seq_len_flag=""
  elif [ "${PHASE}" == "2" ]; then
    readonly target_seq_len_flag="--target-seq-length 512"
  else
    echo "\${PHASE} = ${PHASE} unknown!"
    exit 1
  fi
  # Should we use sequence binning?
  if [ "${BIN_SIZE}" == "none" ]; then
    readonly bin_size_flag=""
  else
    readonly bin_size_flag="--bin-size ${BIN_SIZE}"
  fi
  # Static masking or dynamic masking?
  if [ "${MASKING}" == "dynamic" ]; then
    readonly masking_flag=""
  elif [ "${MASKING}" == "static" ]; then
    readonly masking_flag="--masking"
  else
    echo "\${MASKING} = ${MASKING} unknown!"
    exit 1
  fi
  # Should we use jemalloc for the LDDL preprocessor?
  if [ "${USE_JEMALLOC}" == "true" ]; then
    readonly use_jemalloc_flag="--export=ALL,LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so"
  elif [ "${USE_JEMALLOC}" == "false" ]; then
    readonly use_jemalloc_flag=""
  else
    echo "\${USE_JEMALLOC} = ${USE_JEMALLOC} unknown!"
    exit 1
  fi
  # Run the LDDL preprocessor.
  srun -l \
    --mpi=pmix \
    --container-image="${docker_image}" \
    --container-mounts="${mounts}"  \
    --ntasks-per-node="${DASK_TASKS_PER_NODE}" \
    ${use_jemalloc_flag} \
    preprocess_bert_pretrain \
      --schedule mpi \
      ${target_seq_len_flag} \
      --wikipedia ${container_wikipedia_source} \
      --sink "${container_pretrain_parquet}" \
      --vocab-file /workspace/bert/vocab/vocab \
      --num-blocks "${num_blocks}" \
      --sample-ratio "${SAMPLE_RATIO}" \
      ${bin_size_flag} \
      ${masking_flag} \
      --seed "${SEED}"
  # Run the LDDL load balancer.
  srun -l \
    --mpi=pmix \
    --container-image="${docker_image}" \
    --container-mounts="${mounts}"  \
    --ntasks-per-node="${DASK_TASKS_PER_NODE}" \
    balance_dask_output \
      --indir "${container_pretrain_parquet}" \
      --num-shards "${num_blocks}"
fi
srun -l --container-image="${docker_image}" --container-mounts="${mounts}" --ntasks-per-node="${GPUS}" bash -c "${BERT_CMD}"
