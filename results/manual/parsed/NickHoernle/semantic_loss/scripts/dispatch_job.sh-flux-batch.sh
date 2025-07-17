#!/bin/bash
#FLUX: --job-name=red-cat-5887
#FLUX: -c=2
#FLUX: -t=3600
#FLUX: --urgency=16

echo "Job running on ${SLURM_JOB_NODELIST}"
git_commit="`git rev-parse HEAD`"
echo "Last git commit: ${git_commit}"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"
echo "Setting up bash enviroment"
source ~/.bashrc
set -e
SCRATCH_DISK=/disk/scratch
SCRATCH_HOME=${SCRATCH_DISK}/${USER}
mkdir -p ${SCRATCH_HOME}
CONDA_ENV_NAME=sloss
echo "Activating conda environment: ${CONDA_ENV_NAME}"
conda activate ${CONDA_ENV_NAME}
echo "Moving input data to the compute node's scratch space: $SCRATCH_HOME"
repo_home=/home/${USER}/git/semantic_loss
src_path=${repo_home}/data/
dest_path=${SCRATCH_DISK}/${USER}/sloss
mkdir -p ${dest_path}  # make it if required
rsync --archive --update --compress ${src_path}/ ${dest_path}/data
num_lines=$(ls -l ${dest_path}/* | wc -l)
echo "Number of files at the destination: ${num_lines}"
input_dir=${dest_path}/data
output_dir=${dest_path}
mkdir -p ${output_dir}
mkdir -p ${output_dir}/models
mkdir -p ${output_dir}/logs
cd ~/git/semantic_loss
experiment_text_file=$1
COMMAND="`sed \"${SLURM_ARRAY_TASK_ID}q;d\" scripts/${experiment_text_file}`"
echo "Running provided command: ${COMMAND}"
eval "${COMMAND}"
echo "Command ran successfully!"
echo "Moving output data back to DFS"
src_path=${output_dir}
dest_path=${repo_home}/experiments/
mkdir -p ${dest_path}
rsync --archive --update --compress ${src_path}/ ${dest_path}
echo ""
echo "============"
echo "job finished successfully"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job finished: $dt"
