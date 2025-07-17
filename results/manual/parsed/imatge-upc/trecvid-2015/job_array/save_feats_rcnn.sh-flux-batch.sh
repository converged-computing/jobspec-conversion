#!/bin/bash
#FLUX: --job-name=chunky-buttface-6470
#FLUX: --urgency=16

python ../scripts/python/save_feats.py $SLURM_ARRAY_TASK_ID
