#!/bin/bash
#FLUX: --job-name=S2:reg-LARGE
#FLUX: -t=1080000
#FLUX: --priority=16

python reg_large.py -img_id ${SLURM_ARRAY_TASK_ID}
