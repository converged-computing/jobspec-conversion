#!/bin/bash
#FLUX: --job-name=expensive-peanut-butter-3966
#FLUX: -t=3540
#FLUX: --priority=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source $LUSTRE/mytorch/bin/activate
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
pythonint=$(which python)
srun $LUSTRE/mytorch/bin/python sampleLI.py
