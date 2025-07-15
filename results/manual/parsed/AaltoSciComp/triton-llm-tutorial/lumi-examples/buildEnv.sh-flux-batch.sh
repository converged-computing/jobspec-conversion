#!/bin/bash
#FLUX: --job-name=build_pytorch_env
#FLUX: --queue=dev-g
#FLUX: -t=1800
#FLUX: --priority=16

export PYTHON_ENV_NAME='env_dpo'
export SING_IMAGE='lumi-pytorch-rocm-5.6.1-python-3.10-pytorch-v2.1.0.sif'

export PYTHON_ENV_NAME=env_dpo
export SING_IMAGE=lumi-pytorch-rocm-5.6.1-python-3.10-pytorch-v2.1.0.sif
cp /appl/local/containers/sif-images/lumi-pytorch-rocm-5.6.1-python-3.10-pytorch-v2.1.0.sif ./lumi-pytorch-rocm-5.6.1-python-3.10-pytorch-v2.1.0.sif 
WORKING_DIR=$(pwd)
singularity exec -W $WORKING_DIR -B $WORKING_DIR $SING_IMAGE bash \
-c 'python3 -m venv --system-site-packages $PYTHON_ENV_NAME;. $PYTHON_ENV_NAME/bin/activate; pip install -r requirements.txt'
