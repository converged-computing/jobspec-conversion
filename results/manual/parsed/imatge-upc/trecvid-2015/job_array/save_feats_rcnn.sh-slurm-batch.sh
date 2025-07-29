#!/bin/bash
#FLUX: --job-name=cowy-toaster-1539
#FLUX: --urgency=16

python ../scripts/python/save_feats.py $SLURM_ARRAY_TASK_ID
