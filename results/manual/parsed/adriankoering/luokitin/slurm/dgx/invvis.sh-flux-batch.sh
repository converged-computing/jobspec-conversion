#!/bin/bash
#FLUX: --job-name=extra_rgb_rn34
#FLUX: -c=10
#FLUX: --queue=p2
#FLUX: -t=3600
#FLUX: --priority=15

export WANDB_PROJECT='invvis'
export WANDB_NAME='${SLURM_JOB_NAME}'
export WANDB_JOB_TYPE='devel'
export WANDB_JOB_NAME='${WANDB_NAME}'
export WANDB_TAGS='devel,rgb,extra,resnet34'
export HYDRA_FULL_ERROR='1 '

export WANDB_PROJECT=invvis
export WANDB_NAME=${SLURM_JOB_NAME}
export WANDB_JOB_TYPE=devel
export WANDB_JOB_NAME=${WANDB_NAME}
export WANDB_TAGS="devel,rgb,extra,resnet34"
export HYDRA_FULL_ERROR=1 
srun python train.py experiment=invvis/rgb dataset.data_dir=/home/koering/data/invvis/webds/extra model/encoder=resnet34 # -c job --resolve
