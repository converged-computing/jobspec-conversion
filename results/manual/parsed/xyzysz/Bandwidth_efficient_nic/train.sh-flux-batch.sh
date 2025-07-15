#!/bin/bash
#FLUX: --job-name=allon
#FLUX: -t=432000
#FLUX: --urgency=16

python train.py --cuda --pretrained ${SLURM_ARRAY_TASK_ID}
