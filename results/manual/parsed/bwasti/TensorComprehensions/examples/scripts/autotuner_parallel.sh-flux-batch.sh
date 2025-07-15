#!/bin/bash
#FLUX: --job-name=placid-platanos-8584
#FLUX: --priority=16

export TUNER_THREADS='${TUNER_THREADS:=10}'
export TUNER_GPUS='${TUNER_GPUS:="0"}'
export GPU_NAME='$(nvidia-smi -L | head -n 1 | cut -d'(' -f 1 | cut -d':' -f 2 | sed "s/ //g")'
export TC_PREFIX='$(git rev-parse --show-toplevel)'
export PREFIX='${TC_PREFIX}/examples/results_$(date +%m%d%y)/${GPU_NAME}'
export LOG_DIR='${TC_PREFIX}/examples/results_$(date +%m%d%y)/${GPU_NAME}/logs/${SLURM_ARRAY_JOB_ID}-${SLURM_ARRAY_TASK_ID}'

export TUNER_THREADS=${TUNER_THREADS:=10}
export TUNER_GPUS=${TUNER_GPUS:="0"}
export GPU_NAME=$(nvidia-smi -L | head -n 1 | cut -d'(' -f 1 | cut -d':' -f 2 | sed "s/ //g")
export TC_PREFIX=$(git rev-parse --show-toplevel)
export PREFIX=${TC_PREFIX}/examples/results_$(date +%m%d%y)/${GPU_NAME}
export LOG_DIR=${TC_PREFIX}/examples/results_$(date +%m%d%y)/${GPU_NAME}/logs/${SLURM_ARRAY_JOB_ID}-${SLURM_ARRAY_TASK_ID}
mkdir -p ${LOG_DIR}
mkdir -p ${LOG_DIR}/autotuner
chmod -R 777 ${LOG_DIR}
cat ${TC_PREFIX}/examples/scripts/AUTOTUNER_COMMANDS | grep -v "\#" | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1 | xargs -i echo {} > ${LOG_DIR}/COMMAND
cat ${TC_PREFIX}/examples/scripts/AUTOTUNER_COMMANDS | grep -v "\#" | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1 | xargs -i bash -c "{}"
