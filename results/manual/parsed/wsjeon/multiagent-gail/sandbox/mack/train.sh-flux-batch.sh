#!/bin/bash
#FLUX: --job-name="train"
#FLUX: -c=6
#FLUX: -t=72000
#FLUX: --priority=16

export LC_ALL='C.UTF-8'
export LANG='C.UTF-8'
export CONTAINER_NAME='wsjeon-marl-dev-setting-master-zsh.simg'
export PROJECT_DIR='PycharmProjects/multiagent-gail'

module load singularity
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
echo $HOSTNAME
export CONTAINER_NAME=wsjeon-marl-dev-setting-master-zsh.simg
export PROJECT_DIR=PycharmProjects/multiagent-gail
singularity exec --nv \
        -H $HOME:/home \
        -B $SLURM_TMPDIR:/dataset/ \
        -B $SCRATCH:/tmp_log/ \
        -B $SCRATCH:/final_log/ \
        $SCRATCH/singularity-images/$CONTAINER_NAME \
        python -u $PROJECT_DIR/sandbox/mack/train_with_taskid.py --slurm_task_id=$SLURM_ARRAY_TASK_ID
