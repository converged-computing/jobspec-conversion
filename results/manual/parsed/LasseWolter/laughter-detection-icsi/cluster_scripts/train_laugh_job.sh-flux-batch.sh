#!/bin/bash
#FLUX: --job-name=faux-latke-2784
#FLUX: -c=2
#FLUX: -t=28800
#FLUX: --priority=16

echo "Job running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"
echo "Setting up bash enviroment"
source ~/.bashrc
source ~/home/s1660656/git/laughter-detection-icsi/.env
set -e
SCRATCH_DISK=/disk/scratch
SCRATCH_HOME=${SCRATCH_DISK}/${USER}
mkdir -p ${SCRATCH_HOME}
CONDA_ENV_NAME=pip_kaldi
echo "Activating conda environment: ${CONDA_ENV_NAME}"
conda activate ${CONDA_ENV_NAME}
echo "Moving input data to the compute node's scratch space: $SCRATCH_DISK"
FEATS_DIR=feats
repo_home=/home/${USER}/git/laughter-detection-icsi/
src_path=${repo_home}/data/icsi/${FEATS_DIR}
dest_path=${SCRATCH_HOME}/icsi/${FEATS_DIR}
mkdir -p ${dest_path}  # make it if required
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
echo "Moving checkpoints-data to node's scratch space..."
checkp_path=${SCRATCH_HOME}/icsi/checkpoints
mkdir -p ${checkp_path} # make checkpoint dir if required
src_path=${repo_home}/checkpoints/icsi_cluster
dest_path=${SCRATCH_HOME}/icsi/checkpoints
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
experiment_text_file=$1
COMMAND="`sed \"${SLURM_ARRAY_TASK_ID}q;d\" ${experiment_text_file}`"
echo "Running provided command: ${COMMAND}"
eval "${COMMAND}"
echo "Command ran successfully!"
echo "Moving output data back to DFS"
src_path=${SCRATCH_HOME}/icsi/checkpoints
dest_path=${repo_home}/checkpoints/icsi_cluster
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
echo ""
echo "============"
echo "job finished successfully"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job finished: $dt"
