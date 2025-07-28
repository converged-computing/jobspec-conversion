#!/bin/bash
#FLUX: --job-name=S1:reg-para
#FLUX: -t=1080000
#FLUX: --urgency=16

python para_reg_v3.py -img_id ${SLURM_ARRAY_TASK_ID}
