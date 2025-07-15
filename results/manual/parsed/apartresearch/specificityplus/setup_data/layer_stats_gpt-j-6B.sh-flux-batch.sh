#!/bin/bash
#FLUX: --job-name=ornery-staircase-2844
#FLUX: -c=2
#FLUX: -t=57600
#FLUX: --priority=16

export MODEL='models--EleutherAI--gpt-j-6B'
export PYTHONPATH='/home/${USER}/git/memitpp:${PYTHONPATH}'
export HF_DATASETS_CACHE='${SCRATCH_HOME}/memitpp/data/huggingface/datasets'
export HUGGINGFACE_HUB_CACHE='${SCRATCH_HOME}/memitpp/data/huggingface/hub'

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
export MODEL=models--EleutherAI--gpt-j-6B
export PYTHONPATH=/home/${USER}/git/memitpp:${PYTHONPATH}
echo "Moving input data to the compute node's scratch space: $SCRATCH_DISK"
repo_home=/home/${USER}/git/memitpp
src_path=${repo_home}/data/
dest_path=${SCRATCH_HOME}/memitpp/data
mkdir -p ${dest_path}  # make it if required
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
src_path=/home/${USER}/.cache/huggingface/datasets
dest_path=${SCRATCH_HOME}/memitpp/data/huggingface/datasets
mkdir -p ${dest_path}  # make it if required
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
src_path=/home/${USER}/.cache/huggingface/hub/${MODEL}
dest_path=${SCRATCH_HOME}/memitpp/data/huggingface/hub/${MODEL}
mkdir -p ${dest_path}  # make it if required
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
export HF_DATASETS_CACHE=${SCRATCH_HOME}/memitpp/data/huggingface/datasets
export HUGGINGFACE_HUB_CACHE=${SCRATCH_HOME}/memitpp/data/huggingface/hub
experiment_text_file=$1
COMMAND="`sed \"${SLURM_ARRAY_TASK_ID}q;d\" ${experiment_text_file}`"
echo "Running provided command: ${COMMAND}"
eval "${COMMAND}"
echo "Command ran successfully!"
echo "Moving output data back to DFS"
src_path=${SCRATCH_HOME}/memitpp/data/stats
dest_path=${repo_home}/data/stats
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
echo ""
echo "============"
echo "job finished successfully"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job finished: $dt"
