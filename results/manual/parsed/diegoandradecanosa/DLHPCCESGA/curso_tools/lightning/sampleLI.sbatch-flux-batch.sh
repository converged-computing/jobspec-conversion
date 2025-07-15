#!/bin/bash
#FLUX: --job-name=fuzzy-lamp-5908
#FLUX: -t=3540
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source $LUSTRE/mytorch/bin/activate
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
pythonint=$(which python)
srun $LUSTRE/mytorch/bin/python sampleLI.py
