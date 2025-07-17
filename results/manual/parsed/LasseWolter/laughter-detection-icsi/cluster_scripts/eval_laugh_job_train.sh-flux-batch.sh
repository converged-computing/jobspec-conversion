#!/bin/bash
#FLUX: --job-name=boopy-staircase-9212
#FLUX: -c=2
#FLUX: -t=3600
#FLUX: --urgency=16

echo "Job running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"
echo "Setting up bash enviroment"
source ~/.bashrc
set -e
SCRATCH_DISK=/disk/scratch
SCRATCH_HOME=${SCRATCH_DISK}/${USER}
mkdir -p ${SCRATCH_HOME}
CONDA_ENV_NAME=pip_kaldi
echo "Activating conda environment: ${CONDA_ENV_NAME}"
conda activate ${CONDA_ENV_NAME}
echo "Moving input data to the compute node's scratch space: $SCRATCH_DISK"
repo_home=/home/${USER}/git/laughter-detection-icsi
src_path=${repo_home}/data/icsi/speech/all
dest_path=${SCRATCH_HOME}/icsi/data/speech/all
mkdir -p ${dest_path}  # make it if required
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
experiment_text_file=$1
COMMAND="`sed \"${SLURM_ARRAY_TASK_ID}q;d\" ${experiment_text_file}`"
echo "Running provided command: ${COMMAND}"
eval "${COMMAND}"
echo "Command ran successfully!"
echo "Moving output data back to DFS"
src_path=${SCRATCH_HOME}/icsi/data/eval_output
dest_path=${repo_home}/eval_output/train
mkdir -p ${dest_path}
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
rm ${src_path}/* -rf
echo ""
echo "============"
echo "job finished successfully"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job finished: $dt"
