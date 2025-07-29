#!/bin/bash
#FLUX --job-name=wobbly-lettuce-3776
#FLUX --urgency=16

python ../scripts/python/save_feats.py $SLURM_ARRAY_TASK_ID
