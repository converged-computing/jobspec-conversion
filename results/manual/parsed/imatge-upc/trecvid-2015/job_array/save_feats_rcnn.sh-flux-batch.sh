#!/bin/bash
#FLUX: --job-name=purple-blackbean-9502
#FLUX: --urgency=16

python ../scripts/python/save_feats.py $SLURM_ARRAY_TASK_ID
