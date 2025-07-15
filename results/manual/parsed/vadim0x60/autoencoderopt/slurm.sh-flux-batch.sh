#!/bin/bash
#FLUX: --job-name=autoencoderopt
#FLUX: --queue=mcs.default.q
#FLUX: -t=345600
#FLUX: --urgency=16

export TASK='$(ls datasets | sed -n $SLURM_ARRAY_TASK_ID'p')'

export TASK=$(ls datasets | sed -n $SLURM_ARRAY_TASK_ID'p')
python opt.py
