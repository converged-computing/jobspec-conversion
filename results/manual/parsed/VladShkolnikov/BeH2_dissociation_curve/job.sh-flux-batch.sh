#!/bin/bash
#FLUX: --job-name=fuzzy-leader-1372
#FLUX: -c=4
#FLUX: --urgency=16

source activate chem
python BeH2.py 1.0 1.9 $SLURM_ARRAY_TASK_COUNT $SLURM_ARRAY_TASK_ID
wait
exit 0
