#!/bin/bash
#FLUX: --job-name=diffae
#FLUX: -n=8
#FLUX: --queue=gpuserial
#FLUX: -t=576000
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

set -x
source activate diffae
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
cd /users/PAS2188/brown8258/test/diffae
python run_ffhq256.py
