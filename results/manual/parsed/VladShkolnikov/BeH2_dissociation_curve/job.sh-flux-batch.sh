#!/bin/bash
#FLUX: --job-name=dinosaur-mango-3617
#FLUX: -c=4
#FLUX: --priority=16

source activate chem
python BeH2.py 1.0 1.9 $SLURM_ARRAY_TASK_COUNT $SLURM_ARRAY_TASK_ID
wait
exit 0
