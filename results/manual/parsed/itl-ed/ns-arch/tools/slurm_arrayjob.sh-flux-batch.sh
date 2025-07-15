#!/bin/bash
#FLUX: --job-name=persnickety-latke-3450
#FLUX: -t=21600
#FLUX: --priority=16

echo "Job running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"
echo "Setting up bash enviroment"
source ~/.bashrc
set -e
if [[ -d "/disk/scratch/" ]]
then
    SCRATCH_DISK=/disk/scratch
else
    SCRATCH_DISK=/disk/scratch1
fi
SCRATCH_HOME=${SCRATCH_DISK}/${USER}
mkdir -p ${SCRATCH_HOME}
CONDA_ENV_NAME=xt
echo "Activating conda env: ${CONDA_ENV_NAME}"
conda activate ${CONDA_ENV_NAME}
echo "Moving input data to the compute node's scratch space: $SCRATCH_DISK"
proj_home=/home/${USER}/git/ns-arch
src_path=${proj_home}/datasets
dest_path=${SCRATCH_HOME}/ns-arch/datasets
mkdir -p ${dest_path}  # make it if required
rsync --archive --update --compress --info=progress2 ${src_path}/ ${dest_path}
experiment_text_file=$1
COMMAND="`sed \"${SLURM_ARRAY_TASK_ID}q;d\" ${experiment_text_file}`"
COMMAND="$(echo ${COMMAND} | sed --expression="s|SCRATCHHOME|${SCRATCH_HOME}|g")"
echo "Running provided command: ${COMMAND}"
eval "${COMMAND}"
echo "Command ran successfully!"
echo "Moving output data back to DFS"
src_path=${SCRATCH_HOME}/ns-arch/outputs
dest_path=${proj_home}/outputs
mkdir -p ${dest_path}
rsync --archive --update --compress --info=progress2 ${src_path}/ ${dest_path}
echo ""
echo "============"
echo "job finished successfully"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job finished: $dt"
