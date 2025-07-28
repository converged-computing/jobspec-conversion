#!/bin/bash
#FLUX: --job-name=hello-hippo-4787
#FLUX: --urgency=16

python ../scripts/python/save_feats.py $SLURM_ARRAY_TASK_ID
