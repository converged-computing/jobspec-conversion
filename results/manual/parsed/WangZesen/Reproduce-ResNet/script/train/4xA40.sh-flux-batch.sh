#!/bin/bash
#FLUX: --job-name=resnet
#FLUX: -t=50400
#FLUX: --urgency=16

export LOGLEVEL='INFO'

export LOGLEVEL=INFO
mkdir -p log/$SLURM_JOB_ID
cp $2 log/$SLURM_JOB_ID/data_cfg.toml
cp $3 log/$SLURM_JOB_ID/train_cfg.toml
srun $1 \
    --standalone \
    --nproc_per_node=4 \
    --rdzv-backend=c10d \
    src/train.py --data-cfg log/$SLURM_JOB_ID/data_cfg.toml --train-cfg log/$SLURM_JOB_ID/train_cfg.toml
