#!/bin/bash
#FLUX: --job-name=LiH-dissoc-curve
#FLUX: -c=4
#FLUX: --queue=normal_q
#FLUX: -t=432000
#FLUX: --urgency=16

source activate chem
python BeH2.py 1.0 1.9 $SLURM_ARRAY_TASK_COUNT $SLURM_ARRAY_TASK_ID
wait
exit 0
