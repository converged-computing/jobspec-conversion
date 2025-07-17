#!/bin/bash
#FLUX: --job-name=ImProc_4x
#FLUX: -t=7200
#FLUX: --urgency=16

python batch.py $SLURM_ARRAY_TASK_ID
