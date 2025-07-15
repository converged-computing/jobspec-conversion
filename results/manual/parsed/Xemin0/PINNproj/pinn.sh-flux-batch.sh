#!/bin/bash
#FLUX: --job-name=hanky-cattywampus-1563
#FLUX: --urgency=16

export PYTHONBUFFERED='TRUE'

lscpu
nvidia-smi
export PYTHONBUFFERED=TRUE
module load python/3.11.0 openssl/3.0.0 cuda/11.7.1 cudnn/8.6.0
source ../../jax.venv/bin/activate
python3 train_PINN.py --inverseprob True --savefig True --savemodel True --lamda 10.0,10.0,1.0 --lbfgs 1 --adam 8000
