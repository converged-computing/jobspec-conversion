#!/bin/bash
#FLUX: --job-name=unshuffle
#FLUX: -t=7200
#FLUX: --urgency=16

python unshuffle.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_MAX
