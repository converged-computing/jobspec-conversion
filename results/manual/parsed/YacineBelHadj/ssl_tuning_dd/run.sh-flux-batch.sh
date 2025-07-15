#!/bin/bash
#FLUX: --job-name=arid-hope-6398
#FLUX: -c=4
#FLUX: -t=600
#FLUX: --urgency=16

export MY_APP_ENV='hpc_vub'
export NCCL_DEBUG='INFO'

ENV_NAME=ssl_dd
export MY_APP_ENV=hpc_vub
export NCCL_DEBUG=INFO
module load PyTorch-Lightning/1.7.7-foss-2022a-CUDA-11.7.0
module load Hydra/1.3.2-GCCcore-11.3.0
virtualenv --system-site-packages $ENV_NAME
source $ENV_NAME/bin/activate
python -m pip install --upgrade pip
python -m pip install -e .
chmod +x src/train.py
python ./src/train.py
deactivate
