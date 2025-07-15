#!/bin/bash
#FLUX: --job-name=peachy-staircase-9512
#FLUX: --priority=16

echo "Job running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"
echo "Setting up bash enviroment"
source ~/.bashrc
set -e
SCRATCH_DISK=/disk/scratch
SCRATCH_HOME=${SCRATCH_DISK}/${USER}
mkdir -p ${SCRATCH_HOME}
CONDA_ENV_NAME=cs_example
echo "Activating conda environment: ${CONDA_ENV_NAME}"
conda activate ${CONDA_ENV_NAME}
echo "Moving input data to the compute node's scratch space: $SCRATCH_DISK"
src_path=/home/${USER}/project_name/data/input
dest_path=${SCRATCH_HOME}/project_name/data/input
mkdir -p ${dest_path}  # make it if required
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
experiment_text_file=$1
COMMAND="`sed \"${SLURM_ARRAY_TASK_ID}q;d\" ${experiment_text_file}`"
echo "Running provided command: ${COMMAND}"
eval "${COMMAND}"
echo "Command ran successfully!"
echo "Moving output data back to DFS"
src_path=${SCRATCH_HOME}/project_name/data/output
dest_path=/home/${USER}/project_name/data/output
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
echo ""
echo "============"
echo "job finished successfully"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job finished: $dt"
