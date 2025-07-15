#!/bin/bash
#FLUX: --job-name=strawberry-pot-3200
#FLUX: --urgency=16

python batch.py $SLURM_ARRAY_TASK_ID
