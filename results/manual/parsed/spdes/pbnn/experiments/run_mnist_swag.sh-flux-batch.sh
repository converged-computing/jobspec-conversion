#!/bin/bash
#FLUX: --job-name=crusty-nalgas-1732
#FLUX: -t=3600
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
python mnist/swag.py --id=$SLURM_ARRAY_TASK_ID --adam --lr=0.002 --nlpd_reduce=100
