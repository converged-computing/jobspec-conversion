#!/bin/bash
#FLUX: --job-name=nmt_fineT
#FLUX: -c=4
#FLUX: --queue=preemptgpu
#FLUX: -t=172800
#FLUX: --urgency=16

export WANDB_API_KEY=''
export https_proxy='http://hpc-proxy00.city.ac.uk:3128'

source /opt/flight/etc/setup.sh
flight env activate gridware
module load libs/nvidia-cuda/11.2.0/bin
module load gnu
export WANDB_API_KEY=
echo $WANDB_API_KEY
python --version
wandb login $WANDB_API_KEY --relogin
export https_proxy=http://hpc-proxy00.city.ac.uk:3128
python3 finetunning-t5.py
