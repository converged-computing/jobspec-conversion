#!/bin/bash
#SBATCH --job-name=TensorComprehensions
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=40000
#SBATCH --time=00:02:00

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
