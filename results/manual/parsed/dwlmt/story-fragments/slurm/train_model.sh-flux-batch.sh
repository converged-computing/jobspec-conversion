#!/bin/bash
#FLUX: --job-name=confused-itch-7005
#FLUX: -c=24
#FLUX: --urgency=16

export CURRENT_TIME='$(date "+%Y_%m_%d_%H%M%S")'
export STUDENT_ID='${USER}'
export TOKENIZERS_PARALLELISM='false'
export MKL_SERVICE_FORCE_INTEL='true'
export CLUSTER_HOME='/home/${STUDENT_ID}'
export EXP_ROOT='${CLUSTER_HOME}/git/story-fragments'
export EXP_ID='${EXP_NAME}_${SLURM_JOB_ID}_${CURRENT_TIME}'
export SERIAL_DIR='${SCRATCH_HOME}/${EXP_ID}'
export ALLENNLP_CACHE_ROOT='${SCRATCH_HOME}/allennlp_cache/'
export HF_DATASETS_CACHE='${SCRATCH_HOME}/huggingface_cache/'
export HEAD_EXP_DIR='${CLUSTER_HOME}/runs/${EXP_ID}'

echo "============"
echo "Initialize Env ========"
set -e # fail fast
export CURRENT_TIME=$(date "+%Y_%m_%d_%H%M%S")
source /home/${USER}/miniconda3/bin/activate allennlp
echo "Training ${EXP_NAME} with config ${EXP_CONFIG}"
echo "I'm running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d_%m_%y__%H_%M')
echo ${dt}
export STUDENT_ID=${USER}
export TOKENIZERS_PARALLELISM=false
export MKL_SERVICE_FORCE_INTEL=true
export CLUSTER_HOME="/home/${STUDENT_ID}"
declare -a ScratchPathArray=(/disk/scratch_big/ /disk/scratch1/ /disk/scratch2/ /disk/scratch/ /disk/scratch_fast/)
for i in "${ScratchPathArray[@]}"; do
  echo ${i}
  if [ -d ${i} ] &&  [ -w ${i} ]; then
    export SCRATCH_HOME="${i}/${STUDENT_ID}"
    mkdir -p ${SCRATCH_HOME}
    break
  fi
done
echo ${SCRATCH_HOME}
export EXP_ROOT="${CLUSTER_HOME}/git/story-fragments"
export EXP_ID="${EXP_NAME}_${SLURM_JOB_ID}_${CURRENT_TIME}"
export SERIAL_DIR="${SCRATCH_HOME}/${EXP_ID}"
export ALLENNLP_CACHE_ROOT="${SCRATCH_HOME}/allennlp_cache/"
rm -rf "${SCRATCH_HOME}/allennlp_cache/"
export HF_DATASETS_CACHE="${SCRATCH_HOME}/huggingface_cache/"
cd "${EXP_ROOT}" # helps AllenNLP behave
mkdir -p ${SERIAL_DIR}
echo "============"
echo "ALLENNLP Task========"
echo "${RECOVER_PATH}"
if [ -z "${RECOVER_PATH}" ];
then
  allennlp train --file-friendly-logging --include-package story_fragments \
    --serialization-dir ${SERIAL_DIR}/ ${EXP_CONFIG};
else :
  allennlp train --file-friendly-logging --include-package story_fragments \
  --recover  --serialization-dir ${RECOVER_PATH} ${EXP_CONFIG}; fi
echo "============"
echo "ALLENNLP Task finished"
export HEAD_EXP_DIR="${CLUSTER_HOME}/runs/${EXP_ID}"
mkdir -p "${HEAD_EXP_DIR}"
rsync -avuzhP "${SERIAL_DIR}/" "${HEAD_EXP_DIR}/" # Copy output onto headnode
rm -rf "${SERIAL_DIR}"
echo "============"
echo "results synced"
