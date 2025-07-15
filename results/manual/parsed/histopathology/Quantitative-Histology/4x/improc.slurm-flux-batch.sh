#!/bin/bash
#FLUX: --job-name=wobbly-banana-2057
#FLUX: --priority=16

python batch.py $SLURM_ARRAY_TASK_ID
