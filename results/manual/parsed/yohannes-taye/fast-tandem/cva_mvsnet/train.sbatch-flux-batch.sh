#!/bin/bash
#FLUX: --job-name=gassy-cattywampus-9459
#FLUX: -N=2
#FLUX: -c=3
#FLUX: -t=259200
#FLUX: --urgency=16

export EXP_DIR='/storage/user/koestlel/dr_experiments/slurm/$SLURM_JOB_ID'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export EXP_DIR="/storage/user/koestlel/dr_experiments/slurm/$SLURM_JOB_ID"
echo "Master Node ($(hostname)) is up. Writing to: $EXP_DIR."
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
config=$1
shift 1
srun python train.py --config $config $EXP_DIR TRAIN.DEVICE slurm-ddp $@
