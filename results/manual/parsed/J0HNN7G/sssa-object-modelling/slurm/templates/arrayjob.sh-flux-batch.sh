#!/bin/bash
#FLUX: --job-name=creamy-platanos-8918
#FLUX: --urgency=16

CONDA_ENV_NAME=
MAIN_HOME=/home
MAIN_USER=
MAIN_PROJECT=sssa-object-modelling
MAIN_PATH=${MAIN_HOME}/${MAIN_USER}
MAIN_PROJECT_PATH=${MAIN_PATH}/${MAIN_PROJECT}
SCRATCH_HOME=/disk/scratch
SCRATCH_USER=
SCRATCH_PROJECT=${MAIN_PROJECT}
SCRATCH_PATH=${SCRATCH_HOME}/${SCRATCH_USER}
SCRATCH_PROJECT_PATH=${SCRATCH_PATH}/${SCRATCH_PROJECT}
DATA_DN=data
OUTPUT_DN=ckpt
INPUT_PATH=data/sets
echo "Job running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"
echo "Setting up bash enviroment"
source ~/.bashrc
set -e
mkdir -p ${SCRATCH_PATH}
echo "Activating conda environment: ${CONDA_ENV_NAME}"
conda activate ${CONDA_ENV_NAME}
echo "Moving input data to the compute node's scratch space: $SCRATCH_HOME"
src_path=${MAIN_PROJECT_PATH}/${INPUT_PATH}
dest_path=${SCRATCH_PROJECT_PATH}/${INPUT_PATH}
mkdir -p ${dest_path}  # make it if required
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
experiment_file=$1
ID=$[SLURM_ARRAY_TASK_ID + 1]
EXP="`sed \"${ID}q;d\" ${experiment_file}`"
IFS=$',' read -ra VALS <<< "$EXP"
LEN=${#VALS[@]}
COMMAND=${VALS[$LEN - 1]}
echo "Running provided command: ${COMMAND}"
if eval "${COMMAND}"; then
    echo "Command ran successfully!"
else
    echo "Command failed!"
    exit 1
fi
echo "Moving output data back to DFS"
EXP_NAME=${VALS[$LEN - 2]}
src_path=${SCRATCH_PROJECT_PATH}/${OUTPUT_DN}/${EXP_NAME}
dest_path=${MAIN_PROJECT_PATH}/${OUTPUT_DN}/${EXP_NAME}
mkdir -p ${dest_path}  # make it if required
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
echo "Deleting output files in scratch space"
rm -r ${src_path}/*
echo ""
echo "============"
echo "Job finished successfully!"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job finished: $dt"
