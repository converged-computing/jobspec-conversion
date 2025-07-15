#!/bin/bash
#FLUX: --job-name=w4
#FLUX: -n=4
#FLUX: --queue=mhigh,mlow
#FLUX: --urgency=16

source venv/bin/activate
python m3-project/w4/train.py ${SLURM_ARRAY_TASK_ID}
