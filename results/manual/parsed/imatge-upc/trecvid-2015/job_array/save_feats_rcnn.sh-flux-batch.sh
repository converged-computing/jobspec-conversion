#!/bin/bash
#FLUX --job-name=astute-egg-4918
#FLUX --urgency=16

python ../scripts/python/save_feats.py $SLURM_ARRAY_TASK_ID
