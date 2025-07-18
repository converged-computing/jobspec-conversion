#!/bin/bash
#FLUX: --job-name=phat-blackbean-0652
#FLUX: -t=36000
#FLUX: --urgency=16

export XLA_PYTHON_CLIENT_PREALLOCATE='true'

source ~/.bashrc
export XLA_PYTHON_CLIENT_PREALLOCATE=true
cd $WRKDIR/pbnn
source ./venv/bin/activate
cd ./experiments
if [ ! -d "./results/mnist" ]
then
    echo "Folder does not exist. Now mkdir"
    mkdir ./results/mnist
fi
nvidia-smi
python mnist/ohsmc.py --id=$SLURM_ARRAY_TASK_ID --lr=0.002 --nlpd_reduce=100
