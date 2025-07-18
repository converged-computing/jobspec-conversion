#!/bin/bash
#FLUX: --job-name=jbaik
#FLUX: -N=2
#FLUX: --queue=debug
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export MASTER_ADDR='172.30.1.237'
export MASTER_PORT='23456'

eval "$(pyenv init -)"
export NCCL_DEBUG=INFO
export MASTER_ADDR="172.30.1.237"
export MASTER_PORT="23456"
. .slackbot
srun -o slurmd.%j.%t.out -e slurmd.%j.%t.err --export=ALL --network="MPI,DEVNAME=bond0" \
  python batch_train.py deepspeech_var \
    --use-cuda \
    --slack \
    --tensorboard \
    --checkpoint \
    --log-dir logs_20181113_deepspeech_var_k3_h256l4 \
    --continue-from logs_20181113_deepspeech_var_k3_h256l4/deepspeech_var_epoch_010.pth.tar
