#!/bin/bash
#FLUX: --job-name=sigmasep
#FLUX: -t=0
#FLUX: --priority=16

python experiment.py $SLURM_ARRAY_TASK_ID
