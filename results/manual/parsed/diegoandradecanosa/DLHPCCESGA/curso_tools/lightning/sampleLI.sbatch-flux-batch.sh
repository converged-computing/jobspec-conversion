#!/bin/bash
#FLUX: --job-name=dirty-banana-6521
#FLUX: -N=2
#FLUX: -c=32
#FLUX: -t=3540
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source $LUSTRE/mytorch/bin/activate
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
pythonint=$(which python)
srun $LUSTRE/mytorch/bin/python sampleLI.py
