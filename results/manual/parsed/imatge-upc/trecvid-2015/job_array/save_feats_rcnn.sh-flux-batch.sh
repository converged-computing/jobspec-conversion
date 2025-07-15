#!/bin/bash
#FLUX: --job-name=cowy-banana-3499
#FLUX: --priority=16

python ../scripts/python/save_feats.py $SLURM_ARRAY_TASK_ID
