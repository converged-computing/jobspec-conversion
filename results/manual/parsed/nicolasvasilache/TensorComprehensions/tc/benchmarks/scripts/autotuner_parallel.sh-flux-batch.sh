#!/bin/bash
#FLUX: --job-name=muffled-puppy-1430
#FLUX: --queue=priority,uninterrupted,learnfair,scavenge
#FLUX: --urgency=16

export TUNER_THREADS='${TUNER_THREADS:=20}'
export TUNER_DEVICES='${TUNER_DEVICES:="0,1"}'
export DEVICE_NAME='$(nvidia-smi -L | head -n 1 | cut -d'(' -f 1 | cut -d':' -f 2 | sed "s/ //g")'
export TC_PREFIX='$(git rev-parse --show-toplevel)'
export PREFIX='${TC_PREFIX}/tc/benchmarks/results_$(date +%m%d%y)/${DEVICE_NAME}'
export LOG_DIR='${TC_PREFIX}/tc/benchmarks/results_$(date +%m%d%y)/${DEVICE_NAME}/logs/${SLURM_ARRAY_JOB_ID}-${SLURM_ARRAY_TASK_ID}'

export TUNER_THREADS=${TUNER_THREADS:=20}
export TUNER_DEVICES=${TUNER_DEVICES:="0,1"}
export DEVICE_NAME=$(nvidia-smi -L | head -n 1 | cut -d'(' -f 1 | cut -d':' -f 2 | sed "s/ //g")
export TC_PREFIX=$(git rev-parse --show-toplevel)
export PREFIX=${TC_PREFIX}/tc/benchmarks/results_$(date +%m%d%y)/${DEVICE_NAME}
export LOG_DIR=${TC_PREFIX}/tc/benchmarks/results_$(date +%m%d%y)/${DEVICE_NAME}/logs/${SLURM_ARRAY_JOB_ID}-${SLURM_ARRAY_TASK_ID}
mkdir -p ${LOG_DIR}
chmod -R 777 ${LOG_DIR}
cat ${TC_PREFIX}/tc/benchmarks/scripts/AUTOTUNER_COMMANDS | grep -v "\#" | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1 | xargs -i echo {} > ${LOG_DIR}/COMMAND
cat ${TC_PREFIX}/tc/benchmarks/scripts/AUTOTUNER_COMMANDS | grep -v "\#" | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1 | xargs -i bash -c "{}"
