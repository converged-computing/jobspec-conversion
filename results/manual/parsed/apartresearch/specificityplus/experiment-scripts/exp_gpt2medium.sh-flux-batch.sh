#!/bin/bash
#FLUX: --job-name=angry-knife-8011
#FLUX: -c=2
#FLUX: -t=14400
#FLUX: --urgency=16

export MODEL='models--gpt2-medium'
export MODEL_NAME='gpt2-medium'
export PYTHONPATH='/home/${USER}/git/memitpp:${PYTHONPATH}'
export HF_DATASETS_CACHE='${SCRATCH_HOME}/memitpp/data/huggingface/datasets'
export HUGGINGFACE_HUB_CACHE='${SCRATCH_HOME}/memitpp/data/huggingface/hub'
export START_INDEX='$(printf "%05d" $START_INDEX)'
export DATASET_SIZE='$(printf "%05d" $DATASET_SIZE)'

export MODEL=models--gpt2-medium
export MODEL_NAME=gpt2-medium
echo "Job running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"
echo "Setting up bash enviroment"
source ~/.bashrc
set -e
SCRATCH_DISK=/disk/scratch
SCRATCH_HOME=${SCRATCH_DISK}/${USER}
mkdir -p ${SCRATCH_HOME}
CONDA_ENV_NAME=memit
echo "Activating conda environment: ${CONDA_ENV_NAME}"
conda activate ${CONDA_ENV_NAME}
export PYTHONPATH=/home/${USER}/git/memitpp:${PYTHONPATH}
echo "Moving input data to the compute node's scratch space: $SCRATCH_DISK"
repo_home=/home/${USER}/git/memitpp
src_path=${repo_home}/data/
dest_path=${SCRATCH_HOME}/memitpp/data
mkdir -p ${dest_path}  # make it if required
echo "Moving data from ${src_path} to ${dest_path}"
rsync --archive --update --compress --progress --verbose --log-file=/dev/stdout ${src_path}/ ${dest_path}
src_path=${repo_home}/hparams/
dest_path=${SCRATCH_HOME}/memitpp/hparams
mkdir -p ${dest_path}  # make it if required
echo "Moving data from ${src_path} to ${dest_path}"
rsync --archive --update --compress --progress --verbose --log-file=/dev/stdout ${src_path}/ ${dest_path}
src_path=/home/${USER}/.cache/huggingface/hub/${MODEL}
dest_path=${SCRATCH_HOME}/memitpp/data/huggingface/hub/${MODEL}
mkdir -p ${dest_path}  # make it if required
echo "Moving data from ${src_path} to ${dest_path}"
rsync --archive --update --compress --progress --verbose --log-file=/dev/stdout ${src_path}/ ${dest_path}
export HF_DATASETS_CACHE=${SCRATCH_HOME}/memitpp/data/huggingface/datasets
export HUGGINGFACE_HUB_CACHE=${SCRATCH_HOME}/memitpp/data/huggingface/hub
experiment_text_file=$1
COMMAND="`sed \"${SLURM_ARRAY_TASK_ID}q;d\" ${experiment_text_file}`"
echo "Running provided command: ${COMMAND}"
eval "${COMMAND}"
echo "Command ran successfully!"
echo "Moving output data back to DFS"
export START_INDEX=$(echo $COMMAND | awk -F'--start_index ' '{print $2}' | awk '{print $1}')
export START_INDEX=$(printf "%05d" $START_INDEX)
export DATASET_SIZE=$(echo $COMMAND | awk -F'--dataset_size_limit ' '{print $2}' | awk '{print $1}')
export DATASET_SIZE=$(printf "%05d" $DATASET_SIZE)
src_path=${SCRATCH_HOME}/memitpp/results/combined/${MODEL_NAME}/run_${START_INDEX}_${DATASET_SIZE}
dest_path=${repo_home}/results/combined/${MODEL_NAME}/run_${START_INDEX}_${DATASET_SIZE}
mkdir -p ${dest_path}  # make it if required
echo "Moving data from ${src_path} to ${dest_path}"
rsync --archive --update --compress --progress --verbose --log-file=/dev/stdout ${src_path}/ ${dest_path} 
echo ""
echo "============"
echo "job finished successfully"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job finished: $dt"
